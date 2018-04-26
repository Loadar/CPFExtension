//
//  CPFGradient.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/26.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public class CPFGradient {
    public var size: CGSize = .zero
    public var colors: [UIColor] = []
    public var locations: [Double]? = nil
    
    public var start: CGPoint? = nil
    public var end: CGPoint? = nil
    
    public var style: CPFGradient.Style = .liner
    
    public init() {}
    
    public var image: UIImage? {
        switch style {
        case .liner:
            return UIImage.cpf_gradient(size: size, colors: colors, locations: locations, start: start, end: end)
        case .radial:
            return UIImage.cpf_radialGradient(size: size, colors: colors, locations: locations)
        }
    }
}

extension CPFGradient {
    public enum Style {
        case liner
        case radial
    }
}
