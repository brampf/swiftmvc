//
//  File.swift
//  
//
//  Created by May on 22.06.20.
//

import Foundation

public struct RecentDocument : Codable, Hashable {
    
    public let url : URL
    public internal(set) var date : Date
    
}
