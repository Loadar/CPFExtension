//
//  UIFont+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/27.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension UIFont {
    class func cpf_font(_ name: String? = nil, size: CGFloat) -> UIFont {
        guard let fontName = name else {
            return UIFont.systemFont(ofSize: size)
        }
        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    class func cpf_font(_ name: CPFFontName, size: CGFloat) -> UIFont {
        return self.cpf_font(name.fontName, size: size)
    }
}

public struct CPFFontName {
    // 由于UIFont.Weight枚举仅支持iOS8.2以上，实现自定义的枚举
    public enum Weight: String {
        case ultraLight = "UltraLight"
        case thin = "Thin"
        case light = "Light"
        case regular = "Regular"
        case medium = "Medium"
        case semibold = "SemiBold"
        case bold = "Bold"
        case heavy = "Heavy"
        case black = "Black"
    }
    let fontName: String
    
    public init(fontName: String) {
        self.fontName = fontName
    }
}
