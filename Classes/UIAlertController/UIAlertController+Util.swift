//
//  UIAlertController+Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension UIAlertController {
    public class var cpf_alert: UIAlertController {
        return UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }
    public class var cpf_sheet: UIAlertController {
        return UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    }
}

