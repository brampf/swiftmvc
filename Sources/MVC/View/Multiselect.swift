//
//  File.swift
//  
//
//  Created by May on 09.05.20.
//

import SwiftUI

#if os(iOS)
public struct MultiSelectable : ViewModifier {
    
    var exclusive : () -> Void
    var subsequent : () -> Void
    var random : () -> Void
    var long : (() -> Void)?
    
    public func body(content: Content) -> some View {
        ZStack{
            content.zIndex(0)
            ClickArea(click: exclusive, shiftClick: subsequent, cmdClick: random, longClick: long)
        }
    }
    
}

extension View {
    
    public func selectable(normal: @escaping  () -> Void, shift: @escaping  () -> Void, cmd: @escaping () -> Void, long: (() -> Void)?) -> some View{
        
        return self.modifier(MultiSelectable(exclusive: normal, subsequent: shift, random: cmd, long: long))
    }

    
}


struct ClickArea: UIViewRepresentable {
    
    var click: () -> Void
    var shiftClick: () -> Void
    var cmdClick: () -> Void
    var longClick : (() -> Void)?
    
    func makeUIView(context: UIViewRepresentableContext<ClickArea>) -> UIView {
        let v = UIView(frame: .zero)
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        gesture.delegate = context.coordinator
        let gesture2 = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.long))
        gesture2.minimumPressDuration = 0.5
        //gesture2.delaysTouchesBegan = true
        gesture2.canPrevent(gesture)
        gesture2.delegate = context.coordinator
        
        v.addGestureRecognizer(gesture2)
        v.addGestureRecognizer(gesture)
        
        return v
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        var click: () -> Void
        var shiftClick: () -> Void
        var cmdClick: () -> Void
        var longClick : (() -> Void)?
        
        init(_ click : @escaping () -> Void, _ shift: @escaping () -> Void,_ cmd: @escaping () -> Void,_ long: (() -> Void)?) {
            self.click = click
            self.shiftClick = shift
            self.cmdClick = cmd
        }
        @objc func tapped(gesture:UITapGestureRecognizer) {
            if (gesture.modifierFlags.contains(.shift)){
                self.shiftClick()
            } else if (gesture.modifierFlags.contains(.command)){
                self.cmdClick()
            }else {
                self.click()
            }
        }
        
        @objc func long(gesture:UILongPressGestureRecognizer){
            self.longClick?()
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            
            return true
        }
    }
    
    func makeCoordinator() -> ClickArea.Coordinator {
        return Coordinator(click,shiftClick,cmdClick,longClick)
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<ClickArea>) {
    }
    
}
#endif
