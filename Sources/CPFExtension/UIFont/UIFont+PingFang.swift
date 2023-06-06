//
//  UIFont+PingFang.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension CPFFontName {
    // PingFang SC
    static func pingFang(_ weight: CPFFontName.Weight = .regular) -> CPFFontName {
        let baseName = "PingFangSC"
        var suffix = weight.rawValue
        switch weight {
        case .ultraLight:
            suffix = "Ultralight"
        case .semibold:
            suffix = "Semibold"
        case .light, .regular, .medium, .thin:
            // 与默认后缀相同
            break
        default:
            // 不支持的weight，默认使用regular
            suffix = "Regular"
        }
        let finalName = baseName + "-" + suffix
        return CPFFontName(fontName: finalName)
    }
}

public extension UIFont {
    class func cpf_pingFang(_ size: CGFloat, weight: CPFFontName.Weight = .regular) -> UIFont {
        return UIFont.cpf_font(.pingFang(weight), size: size)
    }
}
