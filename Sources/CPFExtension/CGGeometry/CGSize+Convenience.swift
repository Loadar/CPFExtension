//
//  CGSize+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

public extension CGSize {
    /// width、height使用默认值0
    static func cpf(width: CGFloat = 0, height: CGFloat = 0) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    /// width、height值相同
    static func cpf(_ value: CGFloat) -> CGSize {
        return CGSize(width: value, height: value)
    }
}

extension CGSize: @retroactive CpfCompatible {}

public extension Cpf where Wrapped == CGSize {
    /// 值转换
    func map(_ closour: (CGFloat) -> CGFloat) -> CGSize {
        var size = wrapped
        size.width = closour(size.width)
        size.height = closour(size.height)
        return size
    }
    
    /// width、height按相同比例缩放
    func scale(with scale: CGFloat) -> CGSize {
        map { $0 * scale }
    }
    
    /// 短边对齐、按比例缩放
    func scale(toFit limitedSize: CGSize) -> CGSize {
        let scale = fitScale(to: limitedSize)
        return self.scale(with: scale)
    }
    
    /// 长边对齐、按比例缩放
    func scale(toFill limitedSize: CGSize) -> CGSize {
        let scale = fillScale(to: limitedSize)
        return self.scale(with: scale)
    }
    
    /// 短边对齐的缩放比例
    func fitScale(to limitedSize: CGSize) -> CGFloat {
        let scaleX = limitedSize.width / wrapped.width
        let scaleY = limitedSize.height / wrapped.height
        return min(scaleX, scaleY)
    }
    
    /// 长边对齐的缩放比例
    func fillScale(to limitedSize: CGSize) -> CGFloat {
        let scaleX = limitedSize.width / wrapped.width
        let scaleY = limitedSize.height / wrapped.height
        return max(scaleX, scaleY)
    }
}
