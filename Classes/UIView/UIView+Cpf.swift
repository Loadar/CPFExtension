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
    // MARK: - Line
    @discardableResult
    public func addLine(width: CGFloat? = nil, color: UIColor, from: CGPoint, to: CGPoint) -> Cpf {
        base.cpf_addLine(width: width, color: color, from: from, to: to)
        return self
    }

}
