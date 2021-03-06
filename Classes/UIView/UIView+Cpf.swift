//
//  UIView+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

extension Cpf where Base: UIView {
    // MARK: - Layer Line
    @discardableResult
    public func addLine(width: CGFloat? = nil, color: UIColor, from: CGPoint, to: CGPoint) -> Cpf {
        base.cpf_addLine(width: width, color: color, from: from, to: to)
        return self
    }

    // MARK: - View Line
    @discardableResult
    public func addLine(color: UIColor, configure closure: (UIView) -> Void) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        line.isUserInteractionEnabled = false
        base.addSubview(line)
        closure(line)
        return line
    }
}

// MARK: - hit test
extension Cpf where Base: UIView {
    @discardableResult
    public func hit(insets: UIEdgeInsets) -> Cpf {
        base.cpf_hitTestEdgeInsets = insets
        return self
    }
}
