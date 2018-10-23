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

extension Cpf where Base: CPFGradient {
    @discardableResult
    public func style(_ style: CPFGradient.Style) -> Cpf {
        base.style = style
        return self
    }
    
    @discardableResult
    public func size(_ size: CGSize) -> Cpf {
        base.size = size
        return self
    }
    
    @discardableResult
    public func colors(_ colors: [UIColor]) -> Cpf {
        base.colors = colors
        return self
    }
    
    @discardableResult
    public func locations(_ locations: [Double]) -> Cpf {
        base.locations = locations
        return self
    }
    
    @discardableResult
    public func start(_ start: CGPoint) -> Cpf {
        base.start = start
        return self
    }
    
    @discardableResult
    public func end(_ end: CGPoint) -> Cpf {
        base.end = end
        return self
    }
}

extension Cpf where Base: UITextField {
    @discardableResult
    public func background(radient: CPFGradient, state: UIControl.State? = nil) -> Cpf {
        let image = radient.image
        if state == .disabled {
            base.disabledBackground = image
        } else {
            base.background = image
        }
        return self
    }

    @discardableResult
    public func background(radient: Cpf<CPFGradient>, state: UIControl.State? = nil) -> Cpf {
        return self.background(radient: radient.base, state: state)
    }
}

extension Cpf where Base: UIButton {
    @discardableResult
    public func background(radient: CPFGradient, state: UIControl.State = .normal) -> Cpf {
        base.setBackgroundImage(radient.image, for: state)
        return self
    }
    
    @discardableResult
    public func background(radient: Cpf<CPFGradient>, state: UIControl.State = .normal) -> Cpf {
        return self.background(radient: radient.base, state: state)
    }
}
