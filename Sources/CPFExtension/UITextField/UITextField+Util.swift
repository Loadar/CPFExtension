//
//  UITextField+Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public extension UITextField {
    /// 字符长度(utf8编码)(忽略临时的占位字符(如中文输入等待确认字符串等))
    var cpf_textLength: Int {
        guard let content = self.cpf_textIgnoreMarked else { return 0 }
        return content.lengthOfBytes(using: .utf8)
    }
    
    /// 字符数目(忽略临时的占位字符)
    var cpf_textCount: Int {
        guard let content = self.cpf_textIgnoreMarked else { return 0 }
        return content.count
    }

    /// 去除占位字符后的字串
    var cpf_textIgnoreMarked: String? {
        guard let content = self.text else { return nil }
        
        var finalText = content
        if let language = textInputMode?.primaryLanguage, language == "zh-Hans" {
            if let range = self.markedTextRange, let markedText = self.text(in: range) {
                if let markedRange = content.range(of: markedText) {
                    finalText = content.replacingCharacters(in: markedRange, with: "")
                }
            }
        }
        return finalText
    }
}
