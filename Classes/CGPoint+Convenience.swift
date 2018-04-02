//
//  CGPoint+Convenience.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension CGPoint {
    /// x、y使用默认值0
    public static func cpf(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    /// x、y值相同
    public static func cpf(_ value: CGFloat) -> CGPoint {
        return CGPoint(x: value, y: value)
    }
}
