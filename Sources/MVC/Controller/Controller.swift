//
//  File.swift
//  
//
//  Created by May on 17.05.20.
//

import Foundation


open class Controller : ObservableObject {
    
    /// Publisher for the last error
    @Published public final var fail : Fail?
    
    required public init() {
        
    }
}

extension Controller {
    
    public final func publishFail(_ message: String? = nil, error: Error) {
        DispatchQueue.main.async{
            self.fail = Fail(error, message: message)
        }
    }
    
    public final func publishFail(_ fail: Fail){
        DispatchQueue.main.async {
            self.fail = fail
        }
    }
    
    public final func publishFail(_ error: Error){
        DispatchQueue.main.async {
            self.fail = Fail(error)
        }
    }
    
    public final func publishFail(_ message: String){
        DispatchQueue.main.async {
            self.fail = Fail(nil, message: message)
        }
    }
    
}
