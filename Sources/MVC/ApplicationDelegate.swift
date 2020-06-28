//
//  File 2.swift
//  
//
//  Created by May on 18.05.20.
//
import UIKit
import Foundation


open class ApplicationDelegate<ApplicationController : AppController & ObservableObject> : UIResponder {
    
    public let controller : ApplicationController = ApplicationController.init()
    
}

extension UIApplicationDelegate where Self: SceneConfiguration {
    
    public func sceneForActivity(activity: Activity) -> UISceneConfiguration{
        let setup = self.scenes.first(where: {$0.activity == activity}) ?? mainScene
        return setup.config
    }
    


    
}
