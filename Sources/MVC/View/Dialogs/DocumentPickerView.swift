//
//  DocumentPickerViewController.swift
//  DualVision
//
//  Created by May on 14.03.20.
//  Copyright © 2020 Mayworld. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit

public class DocumentPickerViewController {
    private let onDismiss: (() -> Void)?
    private let onPick: (URL) -> ()
    
    private let multiselect : Bool
    private let supportedTypes : [String]
    
    public init(supportedTypes: [String], multiselect: Bool = true, onPick: @escaping (URL) -> Void, onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        self.onPick = onPick
        self.multiselect = multiselect
        self.supportedTypes = supportedTypes
        
    }
    
    public func show(){
        
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = self.multiselect
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedFileTypes = self.supportedTypes
        
        if (panel.runModal() == NSApplication.ModalResponse.OK) {
            panel.urls.forEach{url in
                    self.onPick(url)
                }
        } else {
            self.onDismiss?()
        }
    }

}
#endif


#if os(iOS)
import UIKit

public class DocumentPickerViewController: UIDocumentPickerViewController {
    private let onDismiss: (() -> Void)?
    private let onPick: (URL) -> ()
    
    public init(supportedTypes: [String], multiselect: Bool = true, onPick: @escaping (URL) -> Void, onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        self.onPick = onPick
        
        super.init(documentTypes: supportedTypes, in: .open)
        
        
        allowsMultipleSelection = multiselect
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show() {
        UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true)
    }
}

extension DocumentPickerViewController: UIDocumentPickerDelegate {
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            onPick(url)
        }
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        onDismiss?()
    }
}
#endif
