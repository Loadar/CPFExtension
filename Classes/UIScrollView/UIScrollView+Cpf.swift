//
//  UIScrollView+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/2.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

extension Cpf where Base: UIScrollView {
    @discardableResult
    public func disableAutoAdjustInset(_ toDisable: Bool) -> Cpf {
        base.cpf_disableInsetAdjust()
        return self
    }
}

extension Cpf where Base: UITableView {
    @discardableResult
    public func disableEstimaiton(_ toDisable: Bool) -> Cpf {
        base.cpf_disableEstimation()
        return self
    }
}

