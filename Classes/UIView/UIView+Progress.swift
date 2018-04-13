//
//  UIView+Progress.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

extension UIView {
    private struct CPFProgressConfigure {
        static var progressKey = 335
    }
    
    public func cpf_showProgress(with style: UIActivityIndicatorViewStyle = .white, offset: CGFloat = 10) {
        var progressView = self.cpf_progressView
        if progressView == nil {
            let theProgressView = UIActivityIndicatorView(activityIndicatorStyle: style)
            self.addSubview(theProgressView)
            theProgressView.frame = CGRect(x: offset, y: bounds.midY - 5, width: 10, height: 10)
            progressView = theProgressView
            self.cpf_progressView = theProgressView
        }
        
        if !progressView!.isAnimating {
            progressView?.startAnimating()
        }
    }
    
    public func cpf_hideProgress() {
        guard let progressView = self.cpf_progressView else { return }
        progressView.stopAnimating()
        progressView.removeFromSuperview()
        self.cpf_progressView = nil
    }
    
    public var cpf_progressView: UIActivityIndicatorView? {
        get { return  objc_getAssociatedObject(self, &CPFProgressConfigure.progressKey) as? UIActivityIndicatorView }
        set { objc_setAssociatedObject(self, &CPFProgressConfigure.progressKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

}

