//
//  File.swift
//  
//
//  Created by May on 10.05.20.
//

import SwiftUI

@available(iOS 13.4, *)
@available(macCatalyst 13.4, *)
public struct DropArea : View {
    
    var handler : UTIHandler
    
    public init(_ handler: UTIHandler){
        self.handler = handler
    }
    
    public var body : some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.secondary)
            .opacity(0.1)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundColor(.accentColor).opacity(0.5))
            .overlay(Image(systemName: "tray.and.arrow.down.fill").foregroundColor(.accentColor))
            .padding()
            .droppable(utis: handler)
            .onTapGesture {
                DocumentPickerViewController(supportedTypes: [self.handler.uti], onPick: self.handler.onResult).show()
        }
    }
    
}
