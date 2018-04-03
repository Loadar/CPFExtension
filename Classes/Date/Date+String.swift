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
        let dateFormatter = Util.shared.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    // 当前为哪一年
    static var cpf_currentYear: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
