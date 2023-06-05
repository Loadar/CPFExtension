//
//  UIImage+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/3.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

public extension Cpf where Wrapped: UIImage {
    static func render(size: CGSize, opaque: Bool = false, scale: CGFloat? = nil, _ renderHandler: () -> Void) -> UIImage? {
        return UIImage.cpf_render(size: size, opaque: opaque, scale: scale, renderHandler)
    }

    static func image(with color: UIColor, size: CGSize? = nil) -> UIImage? {
        return UIImage.cpf_image(with: color, size: size)
    }
    
    func tint(color: UIColor) -> UIImage? {
        return wrapped.cpf_tint(color)
    }
    
    static func gradient(
        size: CGSize,
        colors: [UIColor],
        locations: [Double]? = nil,
        start: CGPoint? = nil,
        end: CGPoint? = nil
    ) -> UIImage? {
        return UIImage.cpf_gradient(size: size, colors: colors, locations: locations, start: start, end: end)
    }
    
    static func radialGradient(
        size: CGSize,
        colors: [UIColor],
        locations: [Double]? = nil,
        radius: CGFloat? = nil,
        center: CGPoint? = nil,
        options: CGGradientDrawingOptions = []
    ) -> UIImage? {
        return UIImage.cpf_radialGradient(
            size: size,
            colors: colors,
            locations: locations,
            radius: radius,
            center: center,
            options: options
        )
    }
    
    func resize(to size: CGSize, opaque: Bool = false) -> UIImage? {
        return wrapped.cpf_resize(to: size, opaque: opaque)
    }
    
    func resize(with scale: CGFloat, opaque: Bool = false) -> UIImage? {
        return wrapped.cpf_resize(with: scale, opaque: opaque)
    }
}
