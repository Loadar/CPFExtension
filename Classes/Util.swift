//
//  Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

public class Util {
    public static let shared = Util()
    private init() {}
    
    // DateFormatter对象生成比较慢，使用全局对象
    lazy public var dateFormatter = {
       return DateFormatter()
    }()
    
    // 默认statusBar，tabBar高度统一
    private var isIPhoneX: Bool?
    private var statusHeight: CGFloat?
    private var tabBarHeight: CGFloat?
    
    public class var screenRect: CGRect { return UIScreen.main.bounds }
    public class var screenSize: CGSize { return screenRect.size }
    public class var screenWidth: CGFloat { return screenRect.width }
    public class var screenHeight: CGFloat { return screenRect.height }
    public class var statusBarHeight: CGFloat {
        if let height = shared.statusHeight { return height }
        let height = UIApplication.shared.statusBarFrame.height
        if height < 1e-6 {
            return isIPhoneX ? 44 : 20
        }
        
        shared.statusHeight = height
        return height
    }
    
    // 根据屏幕尺寸判断是否为iPhoneX
    public class var isIPhoneX: Bool {
        if let status = shared.isIPhoneX { return status }
        let size = screenSize
        let iPhoneXSize = CGSize(width: 375, height: 812)
        let status = abs(size.width - iPhoneXSize.width) < 1e-6 && abs(size.height - iPhoneXSize.height) < 1e-6
        shared.isIPhoneX = status
        return status
    }
    
    public class var topAdjustHeight: CGFloat {
        // iPhoneX顶部控件高度需要调整
        return statusBarHeight - 20
    }
    
    public class var bottomAdjustHeight: CGFloat {
        // iPhoneX底部非列表时，需要留34pt空间
        return isIPhoneX ? 34 : 0
    }
    
    // 取root viewController处理
    public class var tabBarHeight: CGFloat {
        if let height = shared.tabBarHeight { return height }
        guard let controller = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return 0 }
        let rect = controller.tabBar.bounds
        if rect.height > 1e-6 {
            shared.tabBarHeight = rect.height
        }
        return rect.height
    }
}

extension Util {
    public class var topController: UIViewController? {
        var controller = UIApplication.shared.keyWindow?.rootViewController
        while let aController = controller?.presentedViewController {
            controller = aController
        }
        return controller
    }
}

extension Util {
    public class var isSimulator: Bool {
        var isSimulator = false
        #if arch(i386) || arch(x86_64)
        isSimulator = true
        #endif
        return isSimulator
    }
}
