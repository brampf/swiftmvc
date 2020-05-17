//
//  File.swift
//  
//
//  Created by May on 16.05.20.
//
import UIKit
import SwiftUI
import Foundation

public protocol AppConfiguration {
    
    var scenes : Set<SceneConfiguration> { get }
    var mainScene : SceneConfiguration {get}
    
    var appController : AppController {get}
}

extension UIApplicationDelegate where Self : AppConfiguration {
    
    public func sceneConfig(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        var currentScene: SceneConfiguration?
        options.userActivities.forEach { activity in
            currentScene = self.scenes.first(where: {$0.activity == activity.activityType})
        }
        let scene = currentScene ?? mainScene
        return scene.config
    }
    
    
    
}

public struct SceneConfiguration : Hashable {
    
    let activity : String
    let name : String
    let role : UISceneSession.Role
    let sceneDelegate : UIWindowSceneDelegate.Type
    
    public init(_ activity : String, name: String, role: UISceneSession.Role, delegate: UIWindowSceneDelegate.Type) {
        self.activity = activity
        self.name = name
        self.role = role
        self.sceneDelegate = delegate
    }
    
    public var config : UISceneConfiguration {
        let config = UISceneConfiguration(name: name, sessionRole: role)
        config.delegateClass = self.sceneDelegate
        config.sceneClass = UIWindowScene.self
        return config
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(activity)
    }
    
    public static func == (lhs: SceneConfiguration, rhs: SceneConfiguration) -> Bool {
        return lhs.activity == rhs.activity
    }
}
