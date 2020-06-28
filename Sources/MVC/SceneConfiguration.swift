//
//  File.swift
//  
//
//  Created by May on 16.05.20.
//
import UIKit
import SwiftUI
import Foundation

public protocol SceneConfiguration {
    
    var scenes : Set<SceneSetup> { get }
    var mainScene : SceneSetup {get}
}

public typealias Activity = String

public struct SceneSetup : Hashable {
    
    let activity : Activity
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
    
    public static func == (lhs: SceneSetup, rhs: SceneSetup) -> Bool {
        return lhs.activity == rhs.activity
    }
}
