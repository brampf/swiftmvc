//
//  PopupNotification.swift
//  Critique
//
//  Created by May on 12.04.20.
//  Copyright © 2020 Brampf. All rights reserved.
//

import SwiftUI
import Combine

public struct PopupNotification: View {
    
    public enum Duration : Double {
        case QUICK = 0.25
        case READABLE = 0.5
        case LONG = 1
    }
    
    let content : Binding<NotificationView?>
    private var timer : Publishers.Autoconnect<Timer.TimerPublisher>
    
    public init(_ notification : Binding<NotificationView?>){
        self.content = notification
        self.timer = Timer.TimerPublisher(interval: notification.wrappedValue?.duration.rawValue ?? 0.5, runLoop: .main, mode: .common).autoconnect()
    }
    
    public var body: some View {
        content.wrappedValue?.padding()
            .foregroundColor(.black)
            .animation(.easeInOut(duration: animationTime)).transition(.scale)
            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.secondary).opacity(0.99).shadow(color: .black, radius: 5, x: 0, y: 0))
            .onReceive(self.timer) { output in
                self.content.wrappedValue = nil
        }
    }
    
    var animationTime : Double {
        return content.wrappedValue?.duration.rawValue ?? 0 / 2
    }
}

public struct NotificationView : View {
    
    private let view : AnyView
    let duration : PopupNotification.Duration
    
    public init<V>(_ duration: PopupNotification.Duration = .READABLE, _ body: () -> V) where V : View {
        self.duration = duration
        self.view = AnyView(body())
    }
    
    public init(_ duration: PopupNotification.Duration = .READABLE, image: Image?, title: String = "", subtitle: String = "") {
        self.init(duration){
            HStack{
                Spacer()
                VStack{
                    Text(title).font(.largeTitle)
                    if image != nil {
                        image?.font(.largeTitle).padding()
                    }
                    Text(subtitle).bold()
                }
                Spacer()
            }.aspectRatio(1, contentMode: .fill)
                .frame(width: 300, height: 300)
        }
    }
    
    public var body : AnyView {
        return view
    }
}
