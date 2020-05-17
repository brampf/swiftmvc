//
//  AppController.swift
//  OrgaNicer
//
//  Created by May on 06.04.20.
//  Copyright © 2020 Mayworld. All rights reserved.
//
import UIKit
import Foundation

open class AppController : Controller {
    
    @Published public final var debugMode : Bool = false {
        willSet{
            super.objectWillChange.send()
        }
    }
    
    public func newWindow(activity: String) {
        // 3
        let userActivity = NSUserActivity(
            activityType: activity
        )
        // 4
        UIApplication
            .shared
            .requestSceneSessionActivation(
                nil,
                userActivity: userActivity,
                options: nil,
                errorHandler: nil)
        
    }
    
    public func closeActiveWindow() {
        
        if let session = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive})?.session {
            let options = UIWindowSceneDestructionRequestOptions()
            options.windowDismissalAnimation = .commit
            UIApplication.shared.requestSceneSessionDestruction(session, options: options, errorHandler: nil)
        }
    }
}

