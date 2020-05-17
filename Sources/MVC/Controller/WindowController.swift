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
    
    var titleHandler : ((URL) -> Void)?
    
    public var dismiss : (() -> Void)?
    
    open func save(){
        // your code goes here
    }
    
    open func open(url: URL){
        DispatchQueue.main.async{
            self.titleHandler?(url)
            
        }
    }
    
    open var root : AnyView {
        return AnyView(EmptyView())
    }
    
}
