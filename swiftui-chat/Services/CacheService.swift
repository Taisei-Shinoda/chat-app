//
//  CacheService.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/03.
//

import Foundation
import SwiftUI


class CacheService {
    
    private static var imageCache = [String : Image]()
    
    static func getImage(forkey: String) -> Image? {
        return imageCache[forkey]
    }
    
    static func setImage(image: Image, forkey: String) {
        imageCache[forkey] = image
    }
}
