//
//  UIFont+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/27.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension UIFont {
    public class func cpf_font(name: String? = nil, size: CGFloat) -> UIFont {
        guard let fontName = name else {
            return UIFont.systemFont(ofSize: size)
        }
        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public class func cpf_font(name: CPFFontName, size: CGFloat) -> UIFont {
        return self.cpf_font(name: name.fontName, size: size)
    }
}

public struct CPFFontName {
    // 由于UIFont.Weight枚举仅支持iOS8.2以上，实现自定义的枚举
    public enum Weight{
        case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
    }
    let fontName: String
    
    // PingFang SC
    public static func pingFang(_ weight: CPFFontName.Weight = .regular) -> CPFFontName {
        let baseName = "PingFangSC"
        var suffix = self.suffix(of: weight)
        switch weight {
        case .ultraLight:
            suffix = "Ultralight"
        case .semibold:
            suffix = "Semibold"
        case .light, .regular, .medium, .thin:
            suffix = self.suffix(of: weight)
        default:
            // 不支持的weight，默认使用regular
            suffix = "Regular"
        }
        let finalName = baseName + "-" + suffix
        return CPFFontName(fontName: finalName)
    }
    
    public static func suffix(of weight: CPFFontName.Weight) -> String {
        let map: [CPFFontName.Weight: String] = [
            .ultraLight: "UltraLight",
            .thin: "Thin",
            .light: "Light",
            .regular: "Regular",
            .medium: "Medium",
            .semibold: "SemiBold",
            .bold: "Bold",
            .heavy: "Heavy",
            .black: "Black"
        ]
        return map[weight] ?? ""
    }
}

