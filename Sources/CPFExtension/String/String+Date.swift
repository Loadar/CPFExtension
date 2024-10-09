//
//  String+Date.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import Foundation
import CPFChain

extension String: @retroactive CpfCompatible {}

public extension Cpf where Wrapped == String {
    /// 字符串转换成日期
    /// - Parameter format: 字符串的日期格式，默认nil
    ///
    /// 默认的日期格式：
    /// - yyyy-MM-dd HH:mm:ss
    /// - yyyy-MM-dd HH:mm:ss.SSS
    /// - yyyy-MM-dd
    func date(with format: String? = nil) -> Date? {
        let formatter = Util.shared.dateFormatter

        var formatList = [
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd HH:mm:ss.SSS",
            "yyyy-MM-dd"
        ]
        
        if let format = format {
            if formatList.contains(format) {
                formatList.removeAll(where: { $0 == format })
            }
            // 指定的格式优先判断
            formatList.insert(format, at: 0)
        }

        for aFormat in formatList {
            formatter.dateFormat = aFormat
            if let date = formatter.date(from: wrapped) {
                return date
            }
        }
        return nil
    }

    /// 日期字符串转换格式显示
    ///
    /// 注意：支持的日期格式列表参考**func date(with:)**
    ///
    /// - Parameters:
    ///   - fromFormat: 首选源格式，不指定时按照支持的格式列表依次校验
    ///   - toFormat: 目标格式
    /// - Returns: 结果日期文字
    func dateString(from fromFormat: String? = nil, to toFormat: String) -> String {
        guard !wrapped.isEmpty else { return wrapped }
        guard fromFormat != toFormat else { return wrapped }

        guard let date = date(with: fromFormat) else { return "" }
        return date.cpf.string(with: toFormat)
    }
}
