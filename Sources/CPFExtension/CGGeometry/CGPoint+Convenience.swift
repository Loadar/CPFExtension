//
//  CGPoint+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

public extension CGPoint {
    /// 指定x、y生成Point，可使用默认值
    ///
    /// - Parameters:
    ///   - x: x值，默认0
    ///   - y: y值，默认0
    /// - Returns: Point
    static func cpf(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    /// 指定相同的x、y值生成Point
    ///
    /// - Parameter value: x、y值
    /// - Returns: Point
    static func cpf(_ value: CGFloat) -> CGPoint {
        return CGPoint(x: value, y: value)
    }
}

extension CGPoint: @retroactive CpfCompatible {}

public extension Cpf where Wrapped == CGPoint {
    /// 值转换
    func map(_ closour: (CGFloat) -> CGFloat) -> CGPoint {
        var point = wrapped
        point.x = closour(point.x)
        point.y = closour(point.y)
        return point
    }
}
