//
//  UIView+Line.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension UIView {
    /// 在指定view上添加line, width默认1px
    public func cpf_addLine(width: CGFloat? = nil, color: UIColor, from: CGPoint, to: CGPoint) {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        layer.path = path.cgPath
        layer.lineWidth = width ?? 1.0 / UIScreen.main.scale
        layer.strokeColor = color.cgColor
        layer.fillColor = color.cgColor
        self.layer.addSublayer(layer)
    }
}
