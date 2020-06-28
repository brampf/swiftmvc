//
//  File.swift
//  
//
//  Created by May on 18.05.20.
//
import UIKit
import Foundation

public final class ImageProvider : FileProvider, ObservableObject {
    
    @Published public var image : UIImage?
    
    override public func process(_ data: Data, onError: ((Error) -> Void)?) {
        
        DispatchQueue.main.async {
            self.image = UIImage(data: data)
        }
        
    }
    
}
