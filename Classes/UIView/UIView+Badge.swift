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
    
    /// 给当前view添加badge，圆点半径默认5pt，颜色默认red
    public func cpf_addBadge(with radius: CGFloat = 5, color: UIColor = .red, borderColor: UIColor = .white) {
        if cpf_badgeView != nil { return }
        
        // 当前view clipsToBounds必须设置为false，因为badge会超出当前view的bounds
        self.clipsToBounds = false
        
        let badgeView = UIView()
        self.addSubview(badgeView)
        self.cpf_badgeView = badgeView
        
        // frame
        let viewRect = self.bounds
        let badgeRect = CGRect(x: viewRect.maxX - radius, y: 0, width: radius * 2, height: radius * 2)
        badgeView.frame = badgeRect
        
        // attributes
        badgeView.backgroundColor = .red
        badgeView.layer.cornerRadius = radius
        // 增加一个边框以与周围颜色区分
        badgeView.layer.borderWidth = 1 / UIScreen.main.scale
        badgeView.layer.borderColor = borderColor.cgColor
    }
    
    /// 给当前view添加数字badge，背景色默认red，文字颜色默认white，字体默认平方medium 10，文字边距默认2，最大数字默认99，偏移默认右上角(-7, -4)
    public func cpf_addBadge(with count: Int, maxCount: Int = 99, configure handler: (UILabel) -> Void) {
        if cpf_badgeView != nil { return }
        
        // 当前view clipsToBounds必须设置为false，因为badge会超出当前view的bounds
        self.clipsToBounds = false

        let badgeView = UILabel()
        self.addSubview(badgeView)
        self.cpf_badgeView = badgeView

        // attributes
        var text = "\(count)"
        if count > maxCount {
            text = "99+"
        }
        badgeView.font = UIFont.cpf_pingFang(10, weight: .medium)
        badgeView.textAlignment = .center
        badgeView.textColor = .white
        badgeView.backgroundColor = .red
        badgeView.text = text
        var size = text.cpf_size(font: badgeView.font)
        size.width += 2 + 2
        size.height += 2 + 2
        
        // frame
        let viewRect = self.bounds
        let badgeRect = CGRect(x: viewRect.maxX - 7, y: viewRect.minY - 4, width: size.width, height: size.height)
        badgeView.frame = badgeRect

        // 非默认属性，调用方配置
        handler(badgeView)
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

