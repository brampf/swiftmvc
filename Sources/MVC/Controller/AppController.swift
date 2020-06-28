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
    
    @Published public final var debugMode : Bool = false

    @Published public internal(set) final var recentDocuments : [RecentDocument] = []

    open func save() {
        // your code here
    }
    
    internal func persist(){
        
        if let encoded = try? JSONEncoder().encode(recentDocuments) {
            UserDefaults.standard.set(encoded, forKey: "@@recent@@documents@@")
        }
        
        self.save()
    }
    
    internal func restore(){
        
        if let json = UserDefaults.standard.object(forKey: "@@recent@@documents@@") as? Data {
            if let docs = try? JSONDecoder().decode([RecentDocument].self, from: json) {
                self.recentDocuments = docs
            }
        }
    }

    
    internal func addRecentURL(_ url: URL){
        
        if var recent = self.recentDocuments.first(where: {$0.url == url}){
            recent.date = Date()
        } else {
            recentDocuments.append(RecentDocument(url: url, date: Date()))
            if recentDocuments.count > 10 {
                recentDocuments.removeFirst()
            }
        }
        
    }
}
