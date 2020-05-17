//
//  File.swift
//  
//
//  Created by May on 18.04.20.
//

import Foundation

public struct Fail : Identifiable {
    
    public let id = UUID()
    
    public let date = Date()
    public var error : Error?
    public var message: String?
    
    public init(_ error: Error? = nil, message: String? = nil){
        self.error = error
        self.message = message
    }
    
}

extension Fail : Hashable {
    
    public static func == (lhs: Fail, rhs: Fail) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension Fail : CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String{
        return "\(message ?? "N/A") : \(error?.localizedDescription ?? "")"
    }
    
    public var debugDescription: String {
        return self.description
    }
    
}

enum Fails : LocalizedError {
    
    case insufficentPermissions(String)
    
}
