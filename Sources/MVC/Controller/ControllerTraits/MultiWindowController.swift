//
//  File.swift
//  
//
//  Created by May on 20.05.20.
//
import UIKit
import Foundation

public protocol MultiWindowController {
    
    func newWindow(activity: String)
    
    var dismiss : (() -> Void)? {get}
    func closeActiveWindow()
}

extension MultiWindowController {
    
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
