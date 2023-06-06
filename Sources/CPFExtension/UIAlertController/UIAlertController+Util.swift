//
//  UIAlertController+Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension UIAlertController {
    class var cpf_alert: UIAlertController {
        return UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }
    class var cpf_sheet: UIAlertController {
        return UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    }
    class func cpf_alert(with style: UIAlertController.Style = .alert) -> UIAlertController {
        return UIAlertController(title: nil, message: nil, preferredStyle: style)
    }
}
