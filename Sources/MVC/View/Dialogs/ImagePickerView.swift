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

struct ImagePicker : UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    var delegate : (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
        uiViewController.allowsEditing = false
        uiViewController.sourceType = .photoLibrary
        
        uiViewController.delegate = delegate
    }


}
#endif
