//
//  UIAlertController+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

// MARK: -Util
extension Cpf where Base: UIAlertController {
    public static func alert(_ style: UIAlertControllerStyle = .alert) -> Cpf<UIAlertController> {
        return UIAlertController.cpf_alert(with: style).cpf
    }
    
    @discardableResult
    public func title(_ text: String?) -> Cpf {
        base.title = text
        return self
    }
    
    @discardableResult
    public func message(_ text: String?) -> Cpf {
        base.message = text
        return self
    }
    
    @discardableResult
    public func action(_ title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Cpf {
        base.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    
    @discardableResult
    public func cancelled(_ title: String = "取消", handler: ((UIAlertAction) -> Void)? = nil) -> Cpf {
        return self.action(title, style: .cancel, handler: handler)
    }
    
    @discardableResult
    public func action(_ titles: [String], handler: ((UIAlertAction) -> Void)?) -> Cpf {
        titles.forEach { base.addAction(UIAlertAction(title: $0, style: .default, handler: handler)) }
        return self
    }
    
    /// 最后调用present；如果未指定controller，使用top view controller
    public func present(to viewController: UIViewController? = nil) {
        let controller: UIViewController? = viewController ?? self.topController
        controller?.present(base, animated: true, completion: nil)
    }
    
    private var topController: UIViewController? {
        var controller = UIApplication.shared.keyWindow?.rootViewController
        while let aController = controller?.presentedViewController {
            controller = aController
        }
        return controller
    }
    
    public class func alert(title: String? = nil, message: String? = nil, cancel: String = "取消", handler: (() -> Void)? = nil) {
        let controller = UIAlertController.cpf_alert
        controller.title = title
        controller.message = message
        controller.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (_) in
            handler?()
        }))
        controller.cpf.topController?.present(controller, animated: true, completion: nil)
    }
}


