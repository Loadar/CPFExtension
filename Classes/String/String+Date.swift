//
//  String+Date.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import Foundation

extension String {
    /// 转换日期字符串到指定格式的日期字符串
    /// - 日期格式: y: 年，M: 月，d: 日；H: 时，m: 分，s：秒；S: 毫秒
    ///
    /// ```
    /// let from = "2017.10.17 14:56:47.2"
    /// let to = from.dateString(with: "yyyy/MM/dd")
    /// ```
    /// - Note: 需要指定正确的当前日期格式
    /// - Parameters:
    ///   - format: 目标日期格式
    ///   - currentFormat: 当前日期格式, 默认为"yyyy-MM-dd HH:mm:ss.S"
    /// - Returns: 结果字符串
    public func cpf_dateString(with format: String, from currentFormat: String = "yyyy-MM-dd HH:mm:ss.S") -> String {
        let dateFormatter = Util.shared.dateFormatter
        dateFormatter.dateFormat = currentFormat
        guard let date = dateFormatter.date(from: self) else {
            // 转换日期格式出错
            return ""
        }
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    /// 字符串转换成Date对象
    ///
    /// - Parameter format: 指定的日期格式，默认是yyyy-MM-dd HH:mm:ss.S
    /// - Returns: Date对象
    public func cpf_date(_ format: String = "yyyy-MM-dd HH:mm:ss.S") -> Date? {
        let dateFormatter = Util.shared.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
