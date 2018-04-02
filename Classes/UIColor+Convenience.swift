//
//  UIColor+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/15.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension UIColor {
    /// 十六进制颜色字符串生成UIColor对象
    public convenience init(_ string: String) {
        let length = string.lengthOfBytes(using: .utf8)
        guard (length == 6 || length == 8) else {
            // 字符串长度错误，返回clear color
            self.init(white: 0, alpha: 0)
            return
        }
        
        var finalString = string
        // 颜色alpha通道默认为1
        if length == 6 {
            finalString += "ff"
        }
        
        let scanner = Scanner(string: finalString)
        var hexNumber: UInt32 = 0
        let success = scanner.scanHexInt32(&hexNumber)
        
        guard success else {
            // 数据解析失败
            self.init(white: 0, alpha: 0)
            return
        }
        
        let red = (hexNumber >> 24) & 0x000000ff
        let green = (hexNumber >> 16) & 0x000000ff
        let blue = (hexNumber >> 8) & 0x000000ff
        let alpha = hexNumber & 0x000000ff
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    /// 十六进制字符串生成UIColor对象
    public class func cpf(hex string: String) -> UIColor {
        return UIColor(string)
    }
    
    /// 指定rgb数值生成UIColor对象
    /// r、g、b取值0~1
    public class func cpf_rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return cpf_rgba(red, green, blue, 1.0)
    }
    
    /// 指定rgba数值生成UIColor对象
    /// r、g、b、a取值0~1
    public class func cpf_rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 附加alpha值到当前color
    public func cpf(alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    /// 返回十六进制字符串
    public var cpf_hexString: String {
        return cpf_hexString(showAll: false)
    }
    
    public func cpf_hexString(showAll: Bool = true) -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return "00000000"
        }
    
        red *= 255.0
        green *= 255.0
        red *= 255.0
        alpha *= 255.0
        
        var finalValue: Int = Int(blue + 0.5)
        finalValue += Int(green + 0.5) << 8
        finalValue += Int(red + 0.5) << 16
        let alphaValue = Int(alpha + 0.5)
        if showAll || alphaValue < 255 {
            // 显示所以通道或者颜色alpha非1
            finalValue = finalValue << 8 + alphaValue
            return String(format: "%08x", finalValue)
        }
        
        return String(format: "%06x", finalValue)
    }
}

