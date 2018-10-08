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
        if height > 1e-6 {
            // 缓存之
            shared.statusHeight = height
            return height
        }
        
        // 未获取到当前状态栏高度时，使用默认值, iPhoneX系列默认44， 其他默认20
        return isIPhoneX ? 44 : 20
    }
    
    // 根据安全区域判定是否iPhoneX
    public class var isIPhoneX: Bool {
        if let status = shared.isIPhoneX { return status }
        
        // 若安全区域底部大于0，可判定为iPhoneX系列
        var status = false
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first, window.safeAreaInsets.bottom > 0 {
                status = true
            }
        } else {
            // Fallback on earlier versions
        }
        shared.isIPhoneX = status
        return status
    }
    
    public class var topAdjustHeight: CGFloat {
        // iPhoneX顶部控件高度需要调整
        return statusBarHeight - 20
    }
    
    public class var bottomAdjustHeight: CGFloat {
        // iPhoneX底部非列表时，需要留34pt空间(直接指定数值，防止系统的安全区域计算涉及到其他空间)
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
