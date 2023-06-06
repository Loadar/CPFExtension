//
//  CPFGradient+CPf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/26.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

extension CPFGradient: CpfCompatible {}

public extension Cpf where Wrapped: CPFGradient {
    @discardableResult
    func style(_ style: CPFGradient.Style) -> Cpf {
        wrapped.style = style
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> Cpf {
        wrapped.size = size
        return self
    }
    
    @discardableResult
    func colors(_ colors: [UIColor]) -> Cpf {
        wrapped.colors = colors
        return self
    }
    
    @discardableResult
    func locations(_ locations: [Double]) -> Cpf {
        wrapped.locations = locations
        return self
    }
    
    @discardableResult
    func start(_ start: CGPoint) -> Cpf {
        wrapped.start = start
        return self
    }
    
    @discardableResult
    func end(_ end: CGPoint) -> Cpf {
        wrapped.end = end
        return self
    }
}

public extension Cpf where Wrapped: UITextField {
    @discardableResult
    func background(radient: CPFGradient, state: UIControl.State? = nil) -> Cpf {
        let image = radient.image
        if state == .disabled {
            wrapped.disabledBackground = image
        } else {
            wrapped.background = image
        }
        return self
    }

    @discardableResult
    func background(radient: Cpf<CPFGradient>, state: UIControl.State? = nil) -> Cpf {
        return self.background(radient: radient.wrapped, state: state)
    }
}

public extension Cpf where Wrapped: UIButton {
    @discardableResult
    func background(radient: CPFGradient, state: UIControl.State = .normal) -> Cpf {
        wrapped.setBackgroundImage(radient.image, for: state)
        return self
    }
    
    @discardableResult
    func background(radient: Cpf<CPFGradient>, state: UIControl.State = .normal) -> Cpf {
        return self.background(radient: radient.wrapped, state: state)
    }
}
