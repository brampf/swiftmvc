//
//  File.swift
//  
//
//  Created by May on 18.05.20.
//
import UIKit
import Foundation

public final class PlainTextProvider : FileProvider, ObservableObject {
    
    @Published public var text : String?
    
    public var encoding : String.Encoding = .utf8
    
    override public func process(_ data: Data, onError: ((Error) -> Void)?) {
        
        DispatchQueue.main.async {
            self.text = String(data: data, encoding: self.encoding)
        }
        
    }
    
}
