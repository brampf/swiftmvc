//
//  File.swift
//  
//
//  Created by May on 21.05.20.
//

import Foundation

public final class RawDataProvider : FileProvider, ObservableObject {
    
    @Published public var data : Data?
    
    override public func process(_ data: Data, onError: ((Error) -> Void)?) {
        
        DispatchQueue.main.async {
            self.data = data
        }
        
    }
    
}
