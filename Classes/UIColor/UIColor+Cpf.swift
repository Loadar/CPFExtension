//
//  UIColor+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

extension Cpf where Base: UIColor {
    /// 十六进制颜色字符串生成UIColor对象
    ///
    /// - Parameters:
    ///   - text: 十六进制字符串，长度为6或8(包含alpha)
    ///   - alpha: 额外附加的alpha，默认1；若指定此项值，会替代text内可能包含的alpha
    /// - Returns: UIColor对象
    public class func hex(_ text: String, alpha: CGFloat? = nil) -> UIColor {
        return UIColor.cpf_hex(text, alpha: alpha)
    }
    
    /// 以rgb各项值生成UIColor对象
    ///
    /// - Parameters:
    ///   - red: red值
    ///   - green: green值
    ///   - blue: blue值
    ///   - componentMax: 颜色component最大值，将red、green、blue从 0~componentMax 映射到 0~1之间
    /// - Returns: UIColor对象
    public class func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, componentMax: CGFloat = 1) -> UIColor {
        let redValue = min(max(red / componentMax, 0), 1)
        let greenValue = min(max(green / componentMax, 0), 1)
        let blueValue = min(max(blue / componentMax, 0), 1)
        return UIColor.cpf_rgb(redValue, greenValue, blueValue)
    }
    
    /// 以rgba各项值生成UIColor对象
    ///
    /// - Parameters:
    ///   - red: red值
    ///   - green: green值
    ///   - blue: blue值
    ///   - alpha: alpha值, 0~1
    ///   - componentMax: 颜色component最大值，将red、green、blue从 0~componentMax 映射到 0~1之间
    /// - Returns: UIColor对象
    public class func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat, componentMax: CGFloat = 1) -> UIColor {
        let redValue = min(max(red / componentMax, 0), 1)
        let greenValue = min(max(green / componentMax, 0), 1)
        let blueValue = min(max(blue / componentMax, 0), 1)
        let alphaValue = min(max(alpha, 0), 1)
        return UIColor.cpf_rgba(redValue, greenValue, blueValue, alphaValue)
    }
    
    /// 指定alpha值，以base color为基础生成新的color对象
    ///
    /// - Parameter value: alpha值，0~1
    /// - Returns: UIColor对象
    public func alpha(_ value: CGFloat) -> UIColor {
        return base.cpf_alpha(value)
    }
    
    /// 获取base颜色值对应的十六进制字符串
    ///
    /// - Parameter showAll: 是否在alpha为1时，仍显示alpha部分字串
    /// - Returns: 十六进制字串
    public func hexString(showAll: Bool = false) -> String {
        return base.cpf_hexString(showAll: showAll)
    }
}
