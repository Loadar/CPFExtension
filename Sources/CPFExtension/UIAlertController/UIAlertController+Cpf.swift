//
//  UIAlertController+Cpf.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

// MARK: - Util
public extension Cpf where Wrapped: UIAlertController {
    static func alert(_ style: UIAlertController.Style = .alert) -> Cpf<UIAlertController> {
        return UIAlertController.cpf_alert(with: style).cpf
    }
    
    @discardableResult
    func title(_ text: String?) -> Cpf {
        wrapped.title = text
        return self
    }
    
    @discardableResult
    func message(_ text: String?) -> Cpf {
        wrapped.message = text
        return self
    }
    
    @discardableResult
    func action(_ title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Cpf {
        wrapped.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    
    @discardableResult
    func cancelled(_ title: String = "取消", handler: ((UIAlertAction) -> Void)? = nil) -> Cpf {
        return self.action(title, style: .cancel, handler: handler)
    }
    
    @discardableResult
    func action(_ titles: [String], handler: ((UIAlertAction) -> Void)?) -> Cpf {
        titles.forEach { wrapped.addAction(UIAlertAction(title: $0, style: .default, handler: handler)) }
        return self
    }
    
    /// 最后调用present；如果未指定controller，使用top view controller
    func present(to viewController: UIViewController? = nil) {
        let controller: UIViewController? = viewController ?? self.topController
        controller?.present(wrapped, animated: true, completion: nil)
    }
    
    private var topController: UIViewController? {
        var controller = UIApplication.shared.keyWindow?.rootViewController
        while let aController = controller?.presentedViewController {
            controller = aController
        }
        return controller
    }
    
    class func alert(title: String? = nil, message: String? = nil, cancel: String = "取消", handler: (() -> Void)? = nil) {
        let controller = UIAlertController.cpf_alert
        controller.title = title
        controller.message = message
        controller.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (_) in
            handler?()
        }))
        controller.cpf.topController?.present(controller, animated: true, completion: nil)
    }
}
