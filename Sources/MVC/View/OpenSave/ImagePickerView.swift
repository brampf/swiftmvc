//
//  ImagePickerView.swift
//  SecondPerspective
//
//  Created by May on 14.01.20.
//  Copyright © 2020 Mayworld. All rights reserved.
//

#if os(iOS)
import Foundation
import SwiftUI

public struct ImagePicker : UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIImagePickerController
    
    var delegate : (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    
    var completionHandler: (URL) -> Void
    
    public init(_ handler: @escaping (URL) -> Void){
        self.completionHandler = handler
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
        uiViewController.allowsEditing = false
        uiViewController.sourceType = .savedPhotosAlbum
        uiViewController.mediaTypes = ["public.image"]
        
        uiViewController.delegate = context.coordinator
    }

    public func makeCoordinator() -> ImagePickerDelegate {
    
        return ImagePickerDelegate(self.completionHandler)
    }
}

public final class ImagePickerDelegate : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var completionHandler: (URL) -> Void
    
    init(_ handler: @escaping (URL) -> Void){
        self.completionHandler = handler
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let url = info[UIImagePickerController.InfoKey.imageURL]
        self.completionHandler(url as! URL)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        picker.dismiss(animated: true, completion: nil)
        
    }
}

#endif
