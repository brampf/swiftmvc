//
//  File.swift
//  
//
//  Created by May on 25.04.20.
//

import Foundation
import CoreServices

public typealias UTI = String

extension UTI {
    
    public static let IMAGE : UTI = "public.image"
    public static let FOLDER : UTI = "public.folder"
    public static let HTML : UTI = "public.html"
    public static let TEXT : UTI = "public.text"
    public static let MOVIE : UTI = "public.movie"
    public static let AUDIO : UTI = "public.audio"
    public static let DATA : UTI = "public.data"
    public static let PACKAGE : UTI = "public.package"
    public static let RICHTEXT : UTI = kUTTypeRTF as String
    public static let PLAINTEXT : UTI = kUTTypePlainText as String
    
}
