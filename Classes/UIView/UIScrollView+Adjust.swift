//
//  UIScrollView+Adjust.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/2.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension UIScrollView {
    /// iOS11以上，禁止scroll view自动调整content inset
    public func cpf_disableInsetAdjust() {
        // 不使用自动调节Insets
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
    }
}

extension UITableView {
    /// 禁止table view使用estimated参数(全部设置为0)
    public func cpf_disableEstimation() {
        self.estimatedRowHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
    }
}
