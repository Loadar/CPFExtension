//
//  NSObject+Throttle.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// 在一段时间内仅执行闭包一次, 同时禁止其他响应
    ///
    /// - Parameters:
    ///   - time: 时间段，单位秒
    ///   - handler: 要执行的闭包
    public func cpf_performOnce(during time: TimeInterval = 0.5, _ handler: () -> Void) {
        if let date = cpf_performTime {
            if Date().timeIntervalSince(date) < time {
                return
            }
        }
        self.cpf_performTime = Date()
        handler()
    }
    
    private struct CPFThrottleConfigure {
        static var performTime = 0
    }
    
    private var cpf_performTime: Date? {
        get { return objc_getAssociatedObject(self, &CPFThrottleConfigure.performTime) as? Date }
        set { objc_setAssociatedObject(self, &CPFThrottleConfigure.performTime, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
}
