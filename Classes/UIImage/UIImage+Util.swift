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
    
    public class func cpf_image(with color: UIColor, size: CGSize, border: (CGFloat, UIColor)? = nil, corner radius: CGFloat? = nil) -> UIImage? {
        let layer = CALayer()
        layer.backgroundColor = color.cgColor
        let rect = CGRect(origin: .zero, size: size)
        layer.bounds = rect
        if let cornerRadius = radius {
            layer.cornerRadius = cornerRadius
        }
        if let (width, borderColor) = border {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = width
        }

        return cpf_render(size: size) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            layer.render(in: context)
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
    public class func cpf_gradient(size: CGSize, colors: [UIColor], locations: [Double]? = nil, start: CGPoint? = nil, end: CGPoint? = nil) -> UIImage? {
        let scale = UIScreen.main.scale
        let finalSize = CGSize(width: size.width * scale, height: size.height * scale)
        let layer = CAGradientLayer()
        layer.colors = colors.map { $0.cgColor }
        var theLocations = [Double]()
        let count = colors.count
        if locations == nil, count > 1 {
            // 默认数值平均分配
            for i in 0..<count {
                theLocations.append(Double(i) / Double(count - 1))
            }
        } else {
            theLocations = locations!
        }
        layer.locations = theLocations.map { NSNumber(value: $0) }
        
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
    ///   - radius: 总半径，单位为pt，不指定时，默认为图像宽高较长的一边的一般
    ///   - center: 圆心，以单位坐标表示，不指定时为图像中心
    ///   - options: 额外选项, 默认空
    /// - Returns: 结果图像
    public class func cpf_radialGradient(
        size: CGSize,
        colors: [UIColor],
        locations: [Double]? = nil,
        radius: CGFloat? = nil,
        center: CGPoint? = nil,
        options: CGGradientDrawingOptions = []
    ) -> UIImage? {
        let scale = UIScreen.main.scale
        let finalSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        // 圆心
        let finalCenter: CGPoint
        if let center = center {
            finalCenter = CGPoint(x: center.x * finalSize.width, y: center.y * finalSize.height)
        } else {
            finalCenter = CGPoint(x: finalSize.width / 2, y: finalSize.height / 2)
        }
        
        var finalLocations = [Double]()
        let count = colors.count
        if locations == nil, count > 1 {
            // 默认数值平均分配
            for i in 0..<count {
                finalLocations.append(Double(i) / Double(count - 1))
            }
        } else {
            finalLocations = locations!
        }
        
        let space = CGColorSpaceCreateDeviceRGB()
        var components = [CGFloat]()
        for aColor in colors {
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
        let gradient = CGGradient(
            colorSpace: space,
            colorComponents: components,
            locations: nil,//finalLocations.map { CGFloat($0) }//,
            count: colors.count
        )
        if gradient == nil { return nil }
        
        let endRaidus: CGFloat
        if let radius = radius {
            endRaidus = radius * scale
        } else {
            endRaidus = max(finalSize.width, finalSize.width) * 0.5
        }

        return cpf_render(size: finalSize) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            context.drawRadialGradient(
                gradient!,
                startCenter: finalCenter,
                startRadius: 0,
                endCenter: finalCenter,
                endRadius: endRaidus,
                options: options
            )
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

extension UIImage {
    /// 旋转图片一定的弧度
    public func cpf_rotate(_ radian: CGFloat) -> UIImage? {
        return UIImage.cpf_render(size: self.size) {
            let context = UIGraphicsGetCurrentContext()
            context?.translateBy(x: self.size.width / 2, y: self.size.height / 2)
            context?.rotate(by: radian)
            context?.translateBy(x: -self.size.width / 2, y: -self.size.height / 2)
            self.draw(in: CGRect(origin: .zero, size: self.size))
        }
    }
}
