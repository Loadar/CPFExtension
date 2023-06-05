//
//  UITextView+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

public extension Cpf where Wrapped: UITextView {
    var textLength: Int { return wrapped.cpf_textLength }
    var textCount: Int { return wrapped.cpf_textCount }
}
