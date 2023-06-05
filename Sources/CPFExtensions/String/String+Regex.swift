//
//  String+Regex.swift
//  
//
//  Created by Aaron on 2023/6/5.
//

import Foundation
import CPFChain

public extension Cpf where Wrapped == String {
    
    /// 字符是否是数字
    var isNumber: Bool {
        let regex = "[0-9]+"
        return match(regex: regex)
    }
    
    /// 字符串是否是标准整数
    var isNormalizedInt: Bool {
        guard !wrapped.isEmpty else { return false }
        guard wrapped != "0" else { return true }
        let regex = "^[1-9]{1}[0-9]*$"
        return match(regex: regex)
    }
    
    /// 是否是链接
    var isUrl: Bool {
        let regex = "http[s]?\\:\\/\\/(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
        return match(regex: regex)
    }
    
    /// 从字符串中取出链接，如果存在的话
    var urlString: String? {
        let regex = "http[s]?\\:\\/\\/(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
        // 返回第一个链接
        return matchesForRegex(regex: regex)?.first
    }
    
    private func match(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: wrapped)
    }
    
    /// 从输入里返回符合正则表达式的所有字符串
    private func matchesForRegex(regex: String) -> [String]? {
        do {
            let regularExpression = try NSRegularExpression(pattern: regex, options: [])
            let range = NSMakeRange(0, wrapped.count)
            let results = regularExpression.matches(in: wrapped, options: [], range: range)
            let string = wrapped as NSString
            return results.map { string.substring(with: $0.range)}
        } catch {
            return nil
        }
    }
}
