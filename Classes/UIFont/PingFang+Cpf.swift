//
//  PingFang+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/20.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

// MARK: - UILabel
extension Cpf where Base: UILabel {
    @discardableResult
    public func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        base.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}

// MARK: - UITextField
extension Cpf where Base: UITextField {
    @discardableResult
    public func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        base.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}

// MARK: - UIButton
extension Cpf where Base: UIButton {
    @discardableResult
    public func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        base.titleLabel?.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}

// MARK: - UITextView
extension Cpf where Base: UITextView {
    @discardableResult
    public func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        base.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}
