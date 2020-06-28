//
//  File.swift
//  
//
//  Created by May on 16.05.20.
//
import UIKit
import SwiftUI
import Foundation

open class WindowController : Controller {
    
    @Published public var note : NotificationView?
    
    public internal(set) var restorationID : String?
    
    var titleHandler : ((URL) -> Void)?
    
    public var window : (() -> UIWindow)?
    
    public var dismiss : (() -> Void)?
    
    open func save(){
        // your code goes here
    }
    
    open func open(url: URL){

        if let restoreID = restorationID, let data = try? url.bookmarkData() {
            
            UserDefaults.standard.set(data, forKey: restoreID)
        }
        
        DispatchQueue.main.async{
            super.fail = nil
            self.titleHandler?(url)
            
        }
    }
    
    internal func persist(){
        
        
        self.save()
    }
    
    internal func resotre() {
        
        var stale = false
        if let restoreID = restorationID, let data = UserDefaults.standard.data(forKey: restoreID), let url = try? URL(resolvingBookmarkData: data, bookmarkDataIsStale: &stale) {
            self.open(url: url)
        }
        
    }
}
