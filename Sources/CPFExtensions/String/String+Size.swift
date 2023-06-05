//
//  String+Size.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit
import CPFChain

public extension Cpf where Wrapped == String {
    /// 获取指定字体，段落风格(可选)下，当前字符串大小
    /// - Parameters:
    ///   - font: 字体
    ///   - paragraphStyle: 段落风格
    ///   - limited: 限制尺寸
    func size(
        font: UIFont?,
        paragraphStyle: NSParagraphStyle? = nil,
        limited: CGSize? = nil
    ) -> CGSize {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.font] = font
        attributes[.paragraphStyle] = paragraphStyle
        
        let limitedSize: CGSize = limited ?? .cpf(.infinity)
        let rect = wrapped.boundingRect(with:limitedSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size
    }
}
