//
//  UIView+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

public extension Cpf where Wrapped: UIView {
    // MARK: - Layer Line
    @discardableResult
    func addLine(width: CGFloat? = nil, color: UIColor, from: CGPoint, to: CGPoint) -> Cpf {
        wrapped.cpf_addLine(width: width, color: color, from: from, to: to)
        return self
    }

    // MARK: - View Line
    @discardableResult
    func addLine(color: UIColor, configure closure: (UIView) -> Void) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        line.isUserInteractionEnabled = false
        wrapped.addSubview(line)
        closure(line)
        return line
    }
}

// MARK: - hit test
public extension Cpf where Wrapped: UIView {
    @discardableResult
    func hit(insets: UIEdgeInsets) -> Cpf {
        wrapped.cpf_hitTestEdgeInsets = insets
        return self
    }
}
