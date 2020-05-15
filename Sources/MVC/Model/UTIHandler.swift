//
//  File.swift
//  
//
//  Created by May on 14.05.20.
//

import Foundation

protocol ResultType{
    
}

extension Data : ResultType{
    
}

extension URL : ResultType {
    
}

public struct UTIHandler {
    
    public enum Result {
        case URL(onOpen: (URL) -> Void)
        case DATA(onOpen: (Data) -> Void)
    }
    
    let uti : UTI
    let result : Result
    let onError: ((Error) -> Void)?
    
    func onResult<R: ResultType>(_ ret: R) -> Void {
        
        switch result {
        case .URL(let call):
            if let ret = ret as? URL {
                call(ret)
            } else {
                onError?(DropError.wrongType)
            }
        case .DATA(let call) :
            if let ret = ret as? Data {
                call(ret)
            } else {
                onError?(DropError.wrongType)
            }
        }
        
    }
    
    public init(_ uti: UTI, onError: ((Error) -> Void)?, onOpen: Result){
        self.uti = uti
        self.onError = onError
        self.result = onOpen
    }
}

