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
public extension Cpf where Wrapped: UILabel {
    @discardableResult
    func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        wrapped.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}

// MARK: - UITextField
public extension Cpf where Wrapped: UITextField {
    @discardableResult
    func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        wrapped.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}

// MARK: - UIButton
public extension Cpf where Wrapped: UIButton {
    @discardableResult
    func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        wrapped.titleLabel?.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}

// MARK: - UITextView
public extension Cpf where Wrapped: UITextView {
    @discardableResult
    func font(pingfang size: CGFloat, weight: CPFFontName.Weight = .regular) -> Cpf {
        wrapped.font = UIFont.cpf_pingFang(size, weight: weight)
        return self
    }
}
