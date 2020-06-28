//
//  File.swift
//  
//
//  Created by May on 18.05.20.
//

import Foundation

extension URL {
    
    public var uti : UTI {
        
        return (try? self.resourceValues(forKeys: .init(arrayLiteral: .typeIdentifierKey)).typeIdentifier) ?? "UNKNOWN"
        
        
    }
    
}
