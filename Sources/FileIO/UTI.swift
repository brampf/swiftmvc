//
//  File.swift
//  
//
//  Created by May on 25.04.20.
//

import Foundation
import CoreServices

public typealias UTI = String

public extension UTI {
    
    static let IMAGE : UTI = "public.image"
    static let FOLDER : UTI = "public.folder"
    static let HTML : UTI = "public.html"
    static let TEXT : UTI = "public.text"
    static let MOVIE : UTI = "public.movie"
    static let AUDIO : UTI = "public.audio"
    static let DATA : UTI = "public.data"
    static let PACKAGE : UTI = "public.package"
    static let RICHTEXT : UTI = kUTTypeRTF as String
    static let PLAINTEXT : UTI = kUTTypePlainText as String
    
}

import SwiftUI

public extension Image {
    
    init(uti: UTI){
        
        if UTTypeConformsTo(uti as CFString, UTI.FOLDER as CFString) {
            self.init(systemName: "folder")
        } else if UTTypeConformsTo(uti as CFString, UTI.PACKAGE as CFString) {
            self.init(systemName: "cube.box")
        } else if UTTypeConformsTo(uti as CFString, UTI.IMAGE as CFString) {
            self.init(systemName: "photo")
        } else if UTTypeConformsTo(uti as CFString, UTI.HTML as CFString) {
            self.init(systemName: "doc.append")
        } else if UTTypeConformsTo(uti as CFString, UTI.RICHTEXT as CFString) {
            self.init(systemName: "doc.richtext")
        } else if UTTypeConformsTo(uti as CFString, UTI.PLAINTEXT as CFString) {
            self.init(systemName: "doc.plaintext")
        } else if UTTypeConformsTo(uti as CFString, UTI.TEXT as CFString) {
            self.init(systemName: "doc.text")
        } else if UTTypeConformsTo(uti as CFString, UTI.AUDIO as CFString) {
            self.init(systemName: "speaker")
        } else if UTTypeConformsTo(uti as CFString, UTI.MOVIE as CFString) {
            self.init(systemName: "film")
        } else {
            self.init(systemName: "doc")
        }
    }
    
}
