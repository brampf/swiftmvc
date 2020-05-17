//
//  File.swift
//  
//
//  Created by May on 16.05.20.
//
import SwiftUI

struct AppView<Body: View> : View {
    
    @EnvironmentObject var appControl : AppController
    
    public let view : Body
    
    public init(body: Body){
        self.view = body
    }
    
    public var body : some View {
        VStack{
            FailSummary(item: $appControl.fail)
            ZStack{
                self.view
            }
        }
    }
}
