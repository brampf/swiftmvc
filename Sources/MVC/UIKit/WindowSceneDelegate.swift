//
//  File.swift
//  
//
//  Created by May on 16.05.20.
//
import UIKit
import SwiftUI
import Foundation

public class WindowSceneDelegate<Controller: WindowController & ObservableObject, MainController: AppController & ObservableObject, WindowView: RootView>: UIResponder, UIWindowSceneDelegate {
    
    public var window: UIWindow?
    public var controller : Controller?
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        guard let appConfig = UIApplication.shared.delegate as? ApplicationDelegate<MainController> else {return}
        
        
        let controller = Controller.init()
        controller.dismiss = {
            let options = UIWindowSceneDestructionRequestOptions()
            options.windowDismissalAnimation = .commit
            UIApplication.shared.requestSceneSessionDestruction(session, options: options, errorHandler: appConfig.controller.publishFail)
        }
        
        #if targetEnvironment(macCatalyst)
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = .none
            titlebar.toolbar?.isVisible = false
            titlebar.toolbar?.showsBaselineSeparator = true
            titlebar.autoHidesToolbarInFullScreen = true
            
            controller.titleHandler = { url in
                titlebar.representedURL = url
                
                DispatchQueue.main.async {
                    if let control = appConfig.controller as? AppController {
                        control.recentDocuments.append(RecentDocument(url: url, date: Date()))
                    }
                }
            }

        }
        #endif
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = WindowView.init()
            .environmentObject(appConfig.controller)
            .environmentObject(controller)
        
        self.controller = controller
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            self.controller?.restorationID = window.restorationIdentifier
            self.controller?.resotre()
            window.rootViewController = UIHostingController(rootView: contentView)
            
            controller.window = {
                return window
            }
            
            self.window = window
            window.makeKeyAndVisible()
        }
        
        self.scene(scene, openURLContexts: connectionOptions.urlContexts)
    }
    
    public func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if let context = URLContexts.first {
            self.controller?.open(url: context.url)
        } 
        
    }
    
    public func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).

        
        scene.delegate = nil
    }
    
    public func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    public func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    public func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        if let appDelegate =  UIApplication.shared.delegate as? ApplicationDelegate<MainController> {
            appDelegate.controller.restore()
        }
        
        self.controller?.resotre()
    }
    
    public func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        self.controller?.persist()
        
        if let appDelegate =  UIApplication.shared.delegate as? ApplicationDelegate<MainController> {
            appDelegate.controller.persist()
        }
    }
    
    public override func validate(_ command: UICommand) {
        //
    }
    
    public override func buildMenu(with builder: UIMenuBuilder) {
        
        if let menuControl = controller as? MenuController{
            menuControl.buildMenu(with: builder)
        }
    }
}

