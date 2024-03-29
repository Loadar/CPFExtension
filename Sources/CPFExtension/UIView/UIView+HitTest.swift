//
//  UIView+HitTest.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/9/25.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension UIView {
    private struct CPFHitConfiguration {
        static var identifier = 0
    }
    
    /// view响应区域相对其frame的inset
    public var cpf_hitTestEdgeInsets: UIEdgeInsets {
        get {
            if let insets = objc_getAssociatedObject(self, &CPFHitConfiguration.identifier) as? UIEdgeInsets {
                return insets
            }
            return UIEdgeInsets.zero
        }
        set(newValue) {
            objc_setAssociatedObject(self, &CPFHitConfiguration.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // hit test
    func check(point: CGPoint) -> Bool {
        // 根据指定insets，确定按钮响应区域
        let viewBounds = self.bounds
        let hitFrame = viewBounds.inset(by: self.cpf_hitTestEdgeInsets)
        return hitFrame.contains(point)
    }
}

public class CPFContainerView: UIView {
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard !self.isHidden else { return super.point(inside: point, with: event) }
        guard self.cpf_hitTestEdgeInsets != .zero else { return super.point(inside: point, with: event) }
        return self.check(point: point)
    }
}

public extension UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard self.isEnabled && !self.isHidden else { return super.point(inside: point, with: event) }
        guard self.cpf_hitTestEdgeInsets != .zero else { return super.point(inside: point, with: event) }
        return self.check(point: point)
    }
}

public extension UILabel {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard !self.isHidden else { return super.point(inside: point, with: event) }
        guard self.cpf_hitTestEdgeInsets != .zero else { return super.point(inside: point, with: event) }
        return self.check(point: point)
    }
}
