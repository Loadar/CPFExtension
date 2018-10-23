//
//  String+Size.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension String {
    /// 获取指定字体，段落风格(可选)下，当前字符串大小
    public func cpf_size(font: UIFont?, paragraphStyle: NSParagraphStyle? = nil, limited: CGSize? = nil) -> CGSize {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.font] = font
        attributes[.paragraphStyle] = paragraphStyle
        
        let limitedSize: CGSize = limited ?? .cpf(.infinity)
        let rect = self.boundingRect(with:limitedSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size
    }
}
