//
//  CGRect+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

public extension CGRect {
    /// x、y、width、height使用默认值0
    static func cpf(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

extension CGRect: @retroactive CpfCompatible {}

public extension Cpf where Wrapped == CGRect {
    /// 根据指定insets调整rect
    ///
    /// - Parameter insets: 指定的insets
    /// - Returns: 结果rect
    func inset(by insets: UIEdgeInsets) -> CGRect {
        var newRect = wrapped
        newRect.origin.x += insets.left
        newRect.origin.y += insets.top
        newRect.size.width -= insets.left + insets.right
        newRect.size.height -= insets.top + insets.bottom
        return newRect
    }
    
    /// 根据指定缩放参数调整rect
    ///
    /// - Parameter scale: 指定的缩放参数
    /// - Returns: 结果rect
    func scale(with scale: CGFloat) -> CGRect {
        var newRect = wrapped
        newRect.origin.x *= scale
        newRect.origin.y *= scale
        newRect.size.width *= scale
        newRect.size.height *= scale
        return newRect
    }
}
