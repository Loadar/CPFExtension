//
//  UIEdgeInsets+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    public static func cpf(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    public static func cpf(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    public static func cpf(horizontal: CGFloat = 0, vetical: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: vetical, left: horizontal, bottom: vetical, right: horizontal)
    }
}
