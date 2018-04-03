//
//  CGSize+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension CGSize {
    /// width、height使用默认值0
    public static func cpf(width: CGFloat = 0, height: CGFloat = 0) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    /// width、height值相同
    public static func cpf(_ value: CGFloat) -> CGSize {
        return CGSize(width: value, height: value)
    }
}

// Size变换
extension CGSize {
    /// width、height按相同比例缩放
    public func cpf_scale(with scale: CGFloat) -> CGSize {
        var newSize = self
        newSize.width *= scale
        newSize.height *= scale
        return newSize
    }
    
    /// 短边对齐、按比例缩放
    public func cpf_scale(toFit limitedSize: CGSize) -> CGSize {
        let scale = self.cpf_fitScale(to: limitedSize)
        return self.cpf_scale(with: scale)
    }
    
    /// 长边对齐、按比例缩放
    public func cpf_scale(toFill limitedSize: CGSize) -> CGSize {
        let scale = self.cpf_fillScale(to: limitedSize)
        return self.cpf_scale(with: scale)
    }
    
    /// 短边对齐的缩放比例
    public func cpf_fitScale(to limitedSize: CGSize) -> CGFloat {
        let scaleX = limitedSize.width / self.width
        let scaleY = limitedSize.height / self.height
        return min(scaleX, scaleY)
    }
    
    /// 长边对齐的缩放比例
    public func cpf_fillScale(to limitedSize: CGSize) -> CGFloat {
        let scaleX = limitedSize.width / self.width
        let scaleY = limitedSize.height / self.height
        return max(scaleX, scaleY)
    }
}
