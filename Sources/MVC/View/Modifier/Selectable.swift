//
//  File.swift
//  
//
//  Created by May on 27.04.20.
//

import SwiftUI

public struct Selectable<Item: Hashable> : ViewModifier {
    
    var item: Item
    var select : (Item) -> Void
    var deselect : (Item) -> Void

    @State private var selected = false
    
    public func body(content: Content) -> some View {
        content.onTapGesture {
            if self.selected {
                self.deselect(self.item)
                self.selected = false
            } else {
                self.select(self.item)
                self.selected = true
            }
        }
    }
    
}

extension View {
    
    public func selectable<H: Hashable>(_ item: H, onSelect: @escaping  (H) -> Void, onDeselect: @escaping (H) -> Void) -> some View{
        return self.modifier(Selectable(item: item, select: onSelect, deselect: onDeselect))
    }
    
}

extension View {
    
    public func selectable<H: Hashable>(_ item: H, selection: Binding<Set<H>?>) -> some View{
        return self.modifier(Selectable(item: item, select: { item in
            selection.wrappedValue?.insert(item)
        }, deselect: { item in
            selection.wrappedValue?.remove(item)
        }))
    }
    
}
