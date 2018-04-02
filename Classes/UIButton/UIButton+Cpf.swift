//
//  UIButton+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

// MARK: - Response Area
extension Cpf where Base: UIButton {
    @discardableResult
    public func hit(insets: UIEdgeInsets) -> Cpf {
        base.cpf_hitTestEdgeInsets = insets
        return self
    }
}

// MARK: - Util
extension Cpf where Base: UIButton {
    @discardableResult
    public func background(color: UIColor, state: UIControlState) -> Cpf {
        base.cpf_setBackground(color: color, for: state)
        return self
    }
}
