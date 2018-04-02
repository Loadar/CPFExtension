//
//  UIButton+ResponseArea.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/15.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

// 扩大button的响应范围
extension UIButton {
    private struct CPFResponseConfigure {
        static var identifier = 0
    }
    
    /// 按钮响应区域相对其frame的inset
    public var cpf_hitTestEdgeInsets: UIEdgeInsets {
        get {
            if let insets = objc_getAssociatedObject(self, &CPFResponseConfigure.identifier) as? UIEdgeInsets {
                return insets
            }
            return UIEdgeInsets.zero
        }
        set(newValue) {
            objc_setAssociatedObject(self, &CPFResponseConfigure.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard self.isEnabled && !self.isHidden else { return super.point(inside: point, with: event) }
        guard self.cpf_hitTestEdgeInsets != .zero else { return super.point(inside: point, with: event) }
        
        // 根据指定insets，调整按钮响应区域
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.cpf_hitTestEdgeInsets)
        return hitFrame.contains(point)
    }
}

