//
//  UIImage+Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/15.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

// Render
extension UIImage {
    /// 图像渲染
    public class func cpf_render(size: CGSize, opaque: Bool = false, scale: CGFloat? = nil, _ renderHandler: () -> Void) -> UIImage? {
        var image: UIImage? = nil
        let contentScale = scale ?? UIScreen.main.scale
        // 10.0以上使用新的渲染方式
        if #available(iOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.opaque = opaque
            format.scale = contentScale
            image = UIGraphicsImageRenderer(size: size, format: format).image { (context) in
                renderHandler()
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(size, opaque, contentScale)
            renderHandler()
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image
    }
}

// Color
extension UIImage {
    /// 根据颜色生成图像
    ///
    /// - Parameters:
    ///   - color: 指定颜色
    ///   - size: 指定图像大小，默认(1, 1)
    /// - Returns: 结果图像
    public class func cpf_image(with color: UIColor, size: CGSize? = nil) -> UIImage? {
        let imageSize: CGSize = size ?? CGSize(width: 1, height: 1)
        return cpf_render(size: imageSize) {
            let drawRect = CGRect(origin: .zero, size: imageSize)
            color.setFill()
            UIRectFill(drawRect)
        }
    }
    
    /// 转换图像到指定颜色
    ///
    /// - Parameter color: 指定颜色
    /// - Returns: 结果图像
    public func cpf_tint(_ color: UIColor) -> UIImage? {
        return UIImage.cpf_render(size: size) { [weak self] in
            guard let weakSelf = self else { return }
            let drawRect = CGRect(origin: .zero, size: weakSelf.size)
            color.setFill()
            UIRectFill(drawRect)
            weakSelf.draw(in: drawRect, blendMode: .destinationIn, alpha: 1.0)
        }
    }
}

// Gradient
extension UIImage {
    
    /// 生成渐变色图像
    ///
    /// - Parameters:
    ///   - size: 图像大小(单位pt)
    ///   - colors: 颜色列表
    ///   - locations: 位置列表，数目与颜色列表一致
    ///   - start: 起始位置(坐标系归一化，如(0, 0.5)代表左边界中点)
    ///   - end: 结束位置
    /// - Returns: 结果图像
    public class func cpf_gradient(size: CGSize, colors: [(UIColor, Double)], start: CGPoint? = nil, end: CGPoint? = nil) -> UIImage? {
        let scale = UIScreen.main.scale
        let finalSize = CGSize(width: size.width * scale, height: size.height * scale)
        let layer = CAGradientLayer()
        layer.colors = colors.map { $0.0.cgColor }
        layer.locations = colors.map { NSNumber(value: $0.1) }
        
        // start, end point确定渐变方向
        if let point = start { layer.startPoint = point }
        if let point = end { layer.endPoint = point }
        
        layer.frame = CGRect(origin: .zero, size: finalSize)
        
        return cpf_render(size: finalSize) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            layer.render(in: context)
        }
    }
    
    /// 生成辐射分布的渐变色图像(中心向四周渐变)
    ///
    /// - Parameters:
    ///   - size: 图像大小
    ///   - colors: 颜色列表
    ///   - locations: 位置列表，数目与颜色列表一致
    /// - Returns: 结果图像
    public class func cpf_radialGradient(size: CGSize, colors: [(UIColor, Double)]) -> UIImage? {
        let scale = UIScreen.main.scale
        let finalSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        // 圆心
        let center = CGPoint(x: finalSize.width / 2, y: finalSize.height / 2)
        
        let space = CGColorSpaceCreateDeviceRGB()
        var components = [CGFloat]()
        for (aColor, _) in colors {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            aColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            components.append(red)
            components.append(green)
            components.append(blue)
            components.append(alpha)
        }
        let gradient = CGGradient(colorSpace: space,
                                  colorComponents: components,
                                  locations: colors.map { CGFloat($0.1) },
                                  count: colors.count)
        if gradient == nil { return nil }

        return cpf_render(size: finalSize) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            // end radius 使用对角线一半长度, 以保证整个区域无空白
            context.drawRadialGradient(gradient!,
                                       startCenter: center,
                                       startRadius: 1.0,
                                       endCenter: center,
                                       endRadius: sqrt(size.width * size.width + size.height * size.height) / 2,
                                       options:[.drawsBeforeStartLocation, .drawsAfterEndLocation])
        }
    }
}

// Size
extension UIImage {
    /// 调整图片大小(仅用于缩小图片)
    /// 结果图片大小根据指定目标尺寸，使用scaleAspectFit方式计算得到
    ///
    /// - Parameter size: 目标尺寸(pt)
    /// - Returns: 结果图片
    public func cpf_resize(to size: CGSize, opaque: Bool = false) -> UIImage? {
        let scale = self.scale
        let screenScale = UIScreen.main.scale
        // 尺寸转到pt
        var imageSize = self.size
        imageSize.width *= scale / screenScale
        imageSize.height *= scale / screenScale

        let newSize = imageSize.cpf_scale(toFit: size)
        if newSize.width >= self.size.width {
            // 不需要缩小, 返回原图
            return self
        }
        
        return UIImage.cpf_render(size: newSize, opaque: opaque) {
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    public func cpf_resize(with scale: CGFloat, opaque: Bool = false) -> UIImage? {
        let oldScale = self.scale
        if abs(scale - oldScale) < 1e-6 { return self }
        
        var imageSize = self.size
        imageSize.width *= oldScale / scale
        imageSize.height *= oldScale / scale

        return UIImage.cpf_render(size: imageSize, opaque: opaque, scale: scale) {
            self.draw(in: CGRect(origin: .zero, size: imageSize))
        }
    }
}

