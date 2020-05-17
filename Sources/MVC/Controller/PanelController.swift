//
//  File.swift
//  
//
//  Created by May on 17.05.20.
//
import SwiftUI
import Foundation

open class PanelController : Controller {
    
    public var dismiss : (() -> Void)?
    
    open var root : AnyView {
        return AnyView(EmptyView())
    }
    
    
}
