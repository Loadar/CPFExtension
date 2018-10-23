//
//  UIButton+Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

// 指定状态背景色
extension UIButton {
    /// 将背景色以图片代替，可以设置不同状态的背景色
    public func cpf_setBackground(color: UIColor, for state: UIControl.State) {
        DispatchQueue.global().async { [weak self] in
            let image = UIImage.cpf_image(with: color)
            DispatchQueue.main.async {
                self?.setBackgroundImage(image, for: state)
            }
        }
    }
}
