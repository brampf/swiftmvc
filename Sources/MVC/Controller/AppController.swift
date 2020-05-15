//
//  AppController.swift
//  OrgaNicer
//
//  Created by May on 06.04.20.
//  Copyright © 2020 Mayworld. All rights reserved.
//

import Foundation

open class AppController {
    
    /// Publisher for the last error
    @Published public final var fail : Fail?
    
    @Published public final var debugMode : Bool = false
    
    public init(){
        
    }
    
    public func publishFail(_ message: String? = nil, error: Error) {
        DispatchQueue.main.async{
            self.fail = Fail(error, message: message)
        }
    }
    
    public func publishFail(_ fail: Fail){
        DispatchQueue.main.async {
            self.fail = fail
        }
    }
    
    public func publishFail(_ error: Error){
        DispatchQueue.main.async {
            self.fail = Fail(error)
        }
    }
    
    public func publishFail(_ message: String){
        DispatchQueue.main.async {
            self.fail = Fail(nil, message: message)
        }
    }
}

