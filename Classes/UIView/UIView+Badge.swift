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

