//
//  File.swift
//  
//
//  Created by May on 20.04.20.
//

import SwiftUI

public struct FailSummary : View {
    
    @Binding var fail : Fail?
    
    public init(item: Binding<Fail?>){
        self._fail = item
    }
    
    public var body : some View {
        HStack{
            if self.fail != nil{
                Spacer()
                #if os(iOS)
                Image(systemName: "exclamationmark.triangle").font(.largeTitle)
                #endif
                VStack(alignment: .leading){
                    Text("ERROR: \(self.fail?.message ?? "")").lineLimit(1)
                    Text(self.fail!.error.debugDescription).font(.system(.body, design: .monospaced)).lineLimit(5)
                }.padding()
                Spacer()
                #if os(macOS)
                Image(nsImage: NSImage(named: NSImage.stopProgressFreestandingTemplateName)!)
                    .font(.largeTitle)
                .padding(.trailing)
                .onTapGesture {
                    self.fail = nil
                }
                #else
                Image(systemName: "xmark")
                    .font(.largeTitle)
                    .padding(.trailing)
                    .onTapGesture {
                        self.fail = nil
                }
                #endif
                    

            }
        }.background(Color(red: 1, green: 0.1, blue: 0.1)).foregroundColor(.white)
    }
    
}
