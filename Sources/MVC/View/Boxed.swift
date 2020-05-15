//
//  File.swift
//  
//
//  Created by May on 02.05.20.
//

import SwiftUI

struct Boxed : ViewModifier {
    
    var mode : ContentMode
    
    func body(content: Content) -> some View {
        
        VStack(spacing: 0){
            Spacer()
            HStack(spacing: 0){
                Spacer()
                content.aspectRatio(contentMode: .fit)
                Spacer()
            }
            Spacer()
        }
    }
}

extension View {
    
    public func box(_ contentMode: ContentMode) -> some View{
        return self.modifier(Boxed(mode: contentMode))
    }
    
}
