//
//  UIView+SnapShot.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension UIView {
    public func cpf_snapshot(opaque: Bool = false) -> UIImage? {
        let size = self.bounds.size
        return UIImage.cpf_render(size: size, opaque: opaque) {
            if opaque {
                UIColor.white.setFill()
                UIRectFill(CGRect(origin: .zero, size: size))
            }
            guard let context = UIGraphicsGetCurrentContext() else { return }
            self.layer.render(in: context)
        }
    }
}

extension UIView {
    private struct CPFSnapshotConfigure {
        static var snapshotKey = 0
    }
    
    public var cpf_snapshotView: UIView? {
        get {
            if let aView = objc_getAssociatedObject(self, &CPFSnapshotConfigure.snapshotKey) as? UIView {
                return aView
            }
            
            let theView = self.snapshotView(afterScreenUpdates: false)
            self.cpf_snapshotView = theView
            return theView
        }
        set {
            objc_setAssociatedObject(self, &CPFSnapshotConfigure.snapshotKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
