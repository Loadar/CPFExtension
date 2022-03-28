//
//  Date+String.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import Foundation

extension Date {
    public func cpf_string(with format: String) -> String {
        let dateFormatter = Util.shared.dateFormatter(with: format)
        return dateFormatter.string(from: self)
    }
    
    // 当前为哪一年
    public static var cpf_currentYear: String {
        let date = Date()
        let dateFormatter = Util.shared.dateFormatter(with: "yyyy")
        return dateFormatter.string(from: date)
    }
}
