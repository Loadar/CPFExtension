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
    ///   - red: red值，0~1
    ///   - green: green值，0~1
    ///   - blue: blue值，0~1
    /// - Returns: UIColor对象
    public class func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor.cpf_rgb(red, green, blue)
    }
    
    /// 以rgba各项值生成UIColor对象
    ///
    /// - Parameters:
    ///   - red: red值，0~1
    ///   - green: green值，0~1
    ///   - blue: blue值，0~1
    ///   - alpha: alpha值, 0~1
    /// - Returns: UIColor对象
    public class func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor.cpf_rgba(red, green, blue, alpha)
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
