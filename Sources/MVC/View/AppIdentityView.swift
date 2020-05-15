//
//  File.swift
//  
//
//  Created by May on 03.05.20.
//

import SwiftUI

public struct AppInfo : View {
    
    var appIcon: Image
    var appName: String
    var appVersion: String
    var appBuild : String
    
    public init(_ image: Image, name: String, version: String, build: String){
        self.appIcon = image
        self.appName = name
        self.appVersion = version
        self.appBuild = build
    }
    
    public var body : some View {
        HStack{
            appIcon.resizable().aspectRatio(contentMode: .fit).frame(width: 40)
            VStack(alignment: .leading){
                Text(appName).bold()
                Text("\(appVersion) (\(appBuild))")
            }.foregroundColor(.secondary).font(.caption)
            Spacer()
        }.padding()
    }
}
