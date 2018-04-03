//
//  UITextView+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

extension Cpf where Base: UITextView {
    public var textLength: Int { return base.cpf_textLength }
    public var textCount: Int { return base.cpf_textCount }
}
