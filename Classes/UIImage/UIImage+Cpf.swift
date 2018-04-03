//
//  UIImage+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

extension Cpf where Base: UIImage {
    public static func render(size: CGSize, opaque: Bool = false, scale: CGFloat? = nil, _ renderHandler: () -> Void) -> UIImage? {
        return UIImage.cpf_render(size: size, opaque: opaque, scale: scale, renderHandler)
    }

    public static func image(with color: UIColor, size: CGSize? = nil) -> UIImage? {
        return UIImage.cpf_image(with: color, size: size)
    }
    
    public func tint(color: UIColor) -> UIImage? {
        return base.cpf_tint(color)
    }
    
    public static func gradient(size: CGSize, colors: [(UIColor, Double)], start: CGPoint? = nil, end: CGPoint? = nil) -> UIImage? {
        return UIImage.cpf_gradient(size: size, colors: colors, start: start, end: end)
    }
    
    public static func radialGradient(size: CGSize, colors: [(UIColor, Double)]) -> UIImage? {
        return UIImage.cpf_radialGradient(size: size, colors: colors)
    }
    
    public func resize(to size: CGSize, opaque: Bool = false) -> UIImage? {
        return base.cpf_resize(to: size, opaque: opaque)
    }
    
    public func resize(with scale: CGFloat, opaque: Bool = false) -> UIImage? {
        return base.cpf_resize(with: scale, opaque: opaque)
    }
}
