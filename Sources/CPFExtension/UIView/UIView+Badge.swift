//
//  UIView+Badge.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/4/2.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension UIView {
    private struct CPFBadgeConfigure {
        static var badgeKey = 0
    }
    
    /// 添加badge(小红点)到当前view，重复调用时更新已有badge
    ///
    /// - Parameters:
    ///   - radius: badge半径，默认5pt
    ///   - color: badge颜色，默认red
    ///   - handler: 自定义配置闭包，自定义其他配置时使用
    public func cpf_addBadge(radius: CGFloat = 5, color: UIColor = .red, configure handler: ((UIView) -> Void)? = nil) {
        if cpf_badgeView == nil {
            let badgeView = UIView()
            self.addSubview(badgeView)
            
            // 当前view clipsToBounds必须设置为false，因为badge可能会超出当前view的bounds
            self.clipsToBounds = false
            
            self.cpf_badgeView = badgeView
        }
        
        // frame
        let viewFrame = self.bounds
        let badgeRect = CGRect(x: viewFrame.maxX - radius, y: 0, width: radius * 2, height: radius * 2)
        cpf_badgeView?.frame = badgeRect
        
        // attributes
        cpf_badgeView?.backgroundColor = color
        cpf_badgeView?.layer.cornerRadius = radius
        
        if #available(iOS 13.0, *) {
            cpf_badgeView?.layer.cornerCurve = .circular
        } else {
            // do nothing
        }

        // 自定义配置
        if let badgeView = cpf_badgeView, let configureClosure = handler {
            configureClosure(badgeView)
        }
    }
    
    /// 添加badge(数字)到当前view，重复调用时更新已有badge
    /// 背景色默认red，文字颜色默认white，字体默认平方medium 10，文字水平边距默认2，最大数字默认99，偏移默认右上角(-7, -4)
    ///
    /// - Parameters:
    ///   - count: 数值
    ///   - maxCount: 显示的最大数值，超过时显示xx+的样式，默认99
    ///   - handler: 自定义配置闭包，自定义其他配置时使用
    public func cpf_addBadge(count: Int, maxCount: Int = 99, configure handler: ((UILabel) -> Void)?) {
        if cpf_badgeView == nil {
            let label = UILabel()
            self.addSubview(label)
            
            label.font = UIFont.cpf_pingFang(10, weight: .medium)
            label.textAlignment = .center
            label.textColor = .white
            label.backgroundColor = .red
            label.clipsToBounds = true

            // 当前view clipsToBounds必须设置为false，因为badge可能会超出当前view的bounds
            self.clipsToBounds = false
            
            self.cpf_badgeView = label
        }
        
        // 同一个view上不能添加多个badge
        guard let label = cpf_badgeView as? UILabel else { return }
        
        var text = "\(count)"
        if count > maxCount {
            text = "\(maxCount)+"
        }
        
        label.text = text
        var size = text.cpf.size(font: label.font)
        size.width += 2 + 2
        size.height += 1

        // frame
        let viewFrame = self.bounds
        let badgeFrame = CGRect(x: viewFrame.maxX - 7, y: viewFrame.minY - 4, width: max(size.width, size.height), height: size.height)
        label.frame = badgeFrame
        
        let radius = min(badgeFrame.width, badgeFrame.height) / 2
        label.layer.cornerRadius = radius
        if #available(iOS 13.0, *) {
            label.layer.cornerCurve = .circular
        } else {
            // do nothing
        }
        
        // 自定义配置
        handler?(label)

    }
    
    /// 添加badge(文字)到当前view，重复调用更新已有badge
    /// 背景色默认red，文字颜色默认white，字体默认平方medium 10，文字水平边距默认3，偏移默认右上角(-7, -4)
    ///
    /// - Parameters:
    ///   - text: 显示的文本
    ///   - handler: 自定义配置闭包，自定义其他配置时使用
    public func cpf_addBadge(text: String, configure handler: ((UILabel) -> Void)? = nil) {
        if cpf_badgeView == nil {
            let label = UILabel()
            self.addSubview(label)
            
            label.font = UIFont.cpf_pingFang(10, weight: .medium)
            label.textAlignment = .center
            label.textColor = .white
            label.backgroundColor = .red
            label.clipsToBounds = true
            
            // 当前view clipsToBounds必须设置为false，因为badge可能会超出当前view的bounds
            self.clipsToBounds = false
            
            self.cpf_badgeView = label
        }
        
        // 同一个view上不能添加多个badge
        guard let label = cpf_badgeView as? UILabel else { return }
        
        // attributes
        label.text = text
        
        var size = text.cpf.size(font: label.font)
        size.width += 2 + 2
        size.height += 1
        
        // frame
        let viewFrame = self.bounds
        let badgeFrame = CGRect(x: viewFrame.maxX - 7, y: viewFrame.minY - 4, width: max(size.width, size.height), height: size.height)
        label.frame = badgeFrame
        
        let radius = min(badgeFrame.width, badgeFrame.height) / 2
        label.layer.cornerRadius = radius
        if #available(iOS 13.0, *) {
            label.layer.cornerCurve = .circular
        } else {
            // do nothing
        }
        
        // 自定义配置
        handler?(label)
    }

    public func cpf_removeBadge() {
        cpf_badgeView?.removeFromSuperview()
        self.cpf_badgeView = nil
    }
    
    private var cpf_badgeView: UIView? {
        get { return  objc_getAssociatedObject(self, &CPFBadgeConfigure.badgeKey) as? UIView }
        set { objc_setAssociatedObject(self, &CPFBadgeConfigure.badgeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

extension Util {
    /// 根tabbar指定index的item的imageView
    public class func cpf_tabbarImageView(at index: Int) -> UIImageView? {
        guard let controller = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return nil }
        let views = controller.tabBar.subviews
        guard views.count > index + 1 else { return nil }
        return views[index + 1].subviews.first as? UIImageView
    }
}
