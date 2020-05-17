//
//  File.swift
//  
//
//  Created by May on 16.05.20.
//
import UIKit
import SwiftUI
import Foundation

public class WindowSceneDelegate<Controller: WindowController>: UIResponder, UIWindowSceneDelegate {
    
    public var window: UIWindow?
    public var controller : Controller?
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        guard let appConfig = UIApplication.shared.delegate as? AppConfiguration else {return}
        
        let controller = Controller.init()
        controller.dismiss = {
            let options = UIWindowSceneDestructionRequestOptions()
            options.windowDismissalAnimation = .commit
            UIApplication.shared.requestSceneSessionDestruction(session, options: options, errorHandler: appConfig.appController.publishFail)
        }
        
        #if targetEnvironment(macCatalyst)
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .visible
            titlebar.toolbar = .none
            titlebar.toolbar?.isVisible = false
            titlebar.toolbar?.showsBaselineSeparator = false
            titlebar.autoHidesToolbarInFullScreen = true
            controller.titleHandler = { url in
                titlebar.representedURL = url
            }

        }
        #endif
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = AppView(body: controller.root)
            .environmentObject(appConfig.appController)
            .environmentObject(controller)
        
        self.controller = controller
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    public func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if let context = URLContexts.first {
            self.controller?.open(url: context.url)
        } else {
            self.controller?.fail = Fail(message: "openInPlace")
        }
        
    }
    
    public func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        self.controller?.save()
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
    }
    
    public func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    public override func buildMenu(with builder: UIMenuBuilder) {
        //1
        guard builder.system == .main else { return }
        
        //2
        builder.remove(menu: .format)
        builder.remove(menu: .learn)
        builder.remove(menu: .edit)
        
        let selector = #selector(self.close)
        let close = UIKeyCommand(
            title: "Close",
            image: nil,
            action: selector,
            input: "k",
            modifierFlags: [.command],
            propertyList: nil)
        
        //4
        let menu = UIMenu(
            title: "",
            image: nil,
            identifier: UIMenu.Identifier("Close"),
            options: .displayInline,
            children: [close])
        
        //5
        builder.insertChild(menu, atEndOfMenu: .edit)
    }
    
    @objc
    func close() {
        self.controller?.dismiss?()
    }
}

