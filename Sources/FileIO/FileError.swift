//
//  File.swift
//  
//
//  Created by May on 18.05.20.
//

import Foundation

public enum FileError : LocalizedError {
    
    case sandboxIssue(String)
    case wrongPermissions(String)
    case invalidFile(String)
    case fileNotFound(String)
    
}
