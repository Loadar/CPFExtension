//
//  UIColor+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/15.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension UIColor {
    /// 十六进制颜色字符串生成UIColor对象
    ///
    /// - Parameter string: 十六进制字符串，长度为6或8(包含alpha)
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
    
    /// 十六进制颜色字符串生成UIColor对象
    ///
    /// - Parameters:
    ///   - text: 十六进制字符串，长度为6或8(包含alpha)
    ///   - alpha: 额外附加的alpha，若指定此项值，会替代text内可能包含的alpha
    /// - Returns: UIColor对象
    public class func cpf_hex(_ text: String, alpha: CGFloat? = nil) -> UIColor {
        if let colorAlpha = alpha {
            return UIColor(text).withAlphaComponent(colorAlpha)
        }
        return UIColor(text)
    }
    
    /// 以rgb各项值生成UIColor对象
    ///
    /// - Parameters:
    ///   - red: red值，0~1
    ///   - green: green值，0~1
    ///   - blue: blue值，0~1
    /// - Returns: UIColor对象
    public class func cpf_rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return cpf_rgba(red, green, blue, 1.0)
    }
    
    /// 以rgba各项值生成UIColor对象
    ///
    /// - Parameters:
    ///   - red: red值，0~1
    ///   - green: green值，0~1
    ///   - blue: blue值，0~1
    ///   - alpha: alpha值, 0~1
    /// - Returns: UIColor对象
    public class func cpf_rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 指定alpha值，以当前color为基础生成新的color对象
    ///
    /// - Parameter value: alpha值，0~1
    /// - Returns: UIColor对象
    public func cpf_alpha(_ value: CGFloat) -> UIColor {
        return self.withAlphaComponent(value)
    }
    
    /// 获取颜色值对应的十六进制字符串
    ///
    /// - Parameter showAll: 是否在alpha为1时，仍显示alpha部分字串
    /// - Returns: 十六进制字串
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
        blue *= 255.0
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

