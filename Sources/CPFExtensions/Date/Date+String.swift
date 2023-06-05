//
//  Date+String.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import Foundation
import CPFChain

public extension Cpf where Wrapped == Date {
    /// 生成指定格式的字符串
    func string(with format: String) -> String {
        let dateFormatter = Util.shared.dateFormatter(with: format)
        return dateFormatter.string(from: wrapped)
    }

    // 当前年
    static var currentYearString: String {
        Date().cpf.string(with: "yyyy")
    }
}
