//
//  File.swift
//  
//
//  Created by May on 18.04.20.
//

import SwiftUI
import Logging

@available(iOS 13.4, *)
@available(macCatalyst 13.4, *)
struct Dropable : ViewModifier, DropDelegate {
    
    var log : Logger?
    
    var allowedUTIs : [UTIHandler]
    var multifile : Bool = true
    @State private var dropzone : Color = .clear
    
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(dropzone, style: .init(lineWidth: 3, dash: [5,10])).padding().background(Rectangle().foregroundColor(dropzone).opacity(dropzone == .clear ? 0.01 : 0.1)))
            .onDrop(of: allowedUTIs.map{$0.uti}, delegate: self)
    }
    
    func dropEntered(info: DropInfo) {
        if info.hasItemsConforming(to: allowedUTIs.map{$0.uti}){
            dropzone = .green
        } else {
            dropzone = .red
        }
    }
    
    func dropExited(info: DropInfo) {
        self.dropzone = .clear
    }
    
    func performDrop(info: DropInfo) -> Bool {
        self.dropzone = .clear
        return self.open(info.itemProviders(for: allowedUTIs.map{$0.uti}))
    }
    
    
    func open(_ itemProvider: [NSItemProvider]) -> Bool {
        allowedUTIs.forEach { element in
            itemProvider.forEach { provider in
                if provider.hasItemConformingToTypeIdentifier(element.uti){
                    switch element.result {
                    case .URL:
                        openInPlace(provider, handler: element)
                    case .DATA:
                        openAsData(provider, handler: element)
                    }
                    
                }
            }
        }
        return true
    }
    
    func openAsData(_ itemProvider: NSItemProvider, handler: UTIHandler) {
        
        itemProvider.loadDataRepresentation(forTypeIdentifier: handler.uti) { data, error in
            if let error = error, let errorHandler = handler.onError  {
                errorHandler(error)
            } else if let data = data {
                handler.onResult(data)
            } else if let errorHandler = handler.onError {
                errorHandler(DropError.noData)
            } else if let log = self.log {
                log.error("\(error.debugDescription)")
            } else {
                // be quiet
            }
        }
        
    }
    
    func openInPlace(_ itemProvider: NSItemProvider, handler: UTIHandler) {
        
        itemProvider.loadInPlaceFileRepresentation(forTypeIdentifier: handler.uti) { url, inPlace, error in
            if let error = error, let errorHandler = handler.onError  {
                errorHandler(error)
            } else if inPlace, let url = url {
                handler.onResult(url)
            } else if let errorHandler = handler.onError {
                errorHandler(DropError.missingPermission)
            } else if let log = self.log {
                log.error("\(error.debugDescription)")
            } else {
                // be quiet
            }
            
            
        }
        
    }
}


public enum DropError : Error {
    case missingPermission
    case wrongType
    case noData
}

extension View {
    
    public func droppable(_ log: Logger? = nil, utis: UTIHandler...) -> some View{
        return self.modifier(Dropable(log: log, allowedUTIs: utis, multifile: true))
    }
    
}
