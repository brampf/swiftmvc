//
//  File.swift
//  
//
//  Created by May on 03.05.20.
//

import Foundation

// MARK:-
// Quick Access to app Version

#if os(macOS)
import AppKit
extension NSApplicationDelegate {

    /// The app version Number
    public static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    /// The app build number
    public static var buildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    /// The app name
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String ?? ""
    }
}

#else
import UIKit
extension UIApplicationDelegate {
    
    /// The app version Number
    public static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    /// The app build number
    public static var buildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    /// The app name
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String ?? ""
    }
}
#endif
