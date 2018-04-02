//
//  Array+Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    /// 移除指定元素(根据Equatable协议，移除第一个相等元素)
    ///
    /// - Parameter object: 指定元素
    public mutating func cpf_remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
