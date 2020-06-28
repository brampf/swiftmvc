//
//  File.swift
//  
//
//  Created by May on 18.05.20.
//

import Foundation

open class FileProvider {
    
    public enum State {
        case EMPTY
        case LOADING
        case LOADED
        case INVALID
    }
    
    @Published public var state : State = .EMPTY
    @Published public var url : URL
    
    public init(url: URL){
        self.url = url
    }
    
    public func read(from url: URL, onError: ((Error) -> Void)?) {
        
        self.state = .LOADING
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            _ = url.startAccessingSecurityScopedResource()
            
            var error : NSError? = nil
            NSFileCoordinator().coordinate(readingItemAt: url, options: .withoutChanges, error: &error) { file in
                
                _ = file.startAccessingSecurityScopedResource()
                
                do {
                    let data = try Data(contentsOf: url)
                    self.process(data, onError: onError)
                    DispatchQueue.main.async {
                        self.state = .LOADED
                    }
                } catch {
                    onError?(error)
                    DispatchQueue.main.async {
                        self.state = .INVALID
                    }
                }
            }
            if let error = error {
                onError?(error)
            }
        }
    }
    
    open func process(_ data : Data, onError: ((Error) -> Void)?){
        //
    }
    
}
