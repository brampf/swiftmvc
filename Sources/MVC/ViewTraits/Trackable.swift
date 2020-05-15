//
//  File.swift
//  
//
//  Created by May on 01.05.20.
//

import SwiftUI

public struct Trackable<H : Hashable> : ViewModifier {
    
    var id: H
    @Binding var visible : Set<H>
    @Binding var invisible : Set<H>
    
    @State private var selected = false
    
    public func body(content: Content) -> some View {
        content.onAppear {
            self.visible.insert(self.id)
        }.onDisappear{
            self.invisible.remove(self.id)
        }
    }
    
}

extension View {
    
    public func trackable<H: Hashable>(id: H, _ visible: Binding<Set<H>>, _ invisible: Binding<Set<H>>) -> some View{
        return self.modifier(Trackable(id: id, visible: visible, invisible: invisible))
    }
    
}
