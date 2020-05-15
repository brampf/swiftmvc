//
//  ActivityIndicatorView.swift
//  Critique
//
//  Created by May on 12.04.20.
//  Copyright © 2020 Brampf. All rights reserved.
//

import Foundation
import SwiftUI

#if os(iOS)
public struct ActivityIndicator: UIViewRepresentable {
    
    public var isAnimating: Binding<Bool>
    let style: UIActivityIndicatorView.Style
    
    public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style){
        self.isAnimating = isAnimating
        self.style = style
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating.wrappedValue ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
#endif
