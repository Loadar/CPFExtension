//
//  ViewController.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/15.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let testView = UIView()
    let testImageView = UIImageView()
    let button = UIButton(type: .custom)
    let button2 = UIButton(type: .custom)

    private var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let weights: [CPFFontName.Weight: String] = [.ultraLight: "ultraLight", .thin: "thin", .light: "light", .regular: "regular", .medium: "medium", .semibold: "semibold", .bold: "bold", .heavy: "heavy", .black: "black"]
        
        for (aWeight, aText) in weights {
            print(aText, UIFont.cpf_pingFang(12.0, weight: aWeight))
            print(aText, UIFont.cpf_helveticaNeue(aWeight, size: 12.0))

        }
        
        let image = UIImage.cpf_image(with: .white, size: CGSize(width: 120, height: 32), border: (1, .red ), corner: 16)
        
        //print("***")
        
        view.addSubview(testView)
        view.addSubview(testImageView)
        
        testView.frame = CGRect(x: 100, y: 100, width: 120, height: 32)
        testImageView.frame = CGRect(x: 100, y: 200, width: 120, height: 32)
        
        testView.layer.borderWidth = 1
        testView.layer.borderColor = UIColor.red.cgColor
        testView.backgroundColor = .white
        testView.layer.cornerRadius = 16
        testView.clipsToBounds = true
        
        testImageView.image = image
        
        
        view.addSubview(button)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "message"), for: .normal)
        button.frame = CGRect(x: 100, y: 300, width: 20, height: 20)
        
        
        view.addSubview(button2)
        button2.setTitle("INS热图", for: .normal)
        button2.setTitleColor(UIColor.darkGray, for: .normal)
        button2.frame = CGRect(x: 100, y: 500, width: 120, height: 20)
        if let size: CGSize = button2.currentTitle?.cpf_size(font: button2.titleLabel?.font) {
            button2.frame.size.width = size.width
        }
        button2.cpf_addBadge(text: "hot") { (label) in
            var frame = label.frame
            frame.size.width += 1 + 1 // 默认2边距，改成3边距
            //label.clipsToBounds = true
            label.frame = frame
            label.layer.cornerRadius = 0
            
            let maskLayer = CAShapeLayer()
            let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: frame.size),
                                    byRoundingCorners: [.topLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 6, height: 6))
            maskLayer.path = path.cgPath
            label.layer.mask = maskLayer
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateBaged(_:)), userInfo: nil, repeats: true)
        
        
        print(Util.isIPhoneX, Util.statusBarHeight, Util.topAdjustHeight, Util.bottomAdjustHeight)
        
    }
    
    @objc private func updateBaged(_ timer: Timer) {
        count += 1
        button.cpf_addBadge(count: count) { (label) in
            label.backgroundColor = .cpf_hex("ff5172")
        }
        
        if count > 110 {
            timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension CPFFontName {
    static func helveticaNeue(_ weight: CPFFontName.Weight = .regular) -> CPFFontName {
        let baseName = "HelveticaNeue"
        var suffix = weight.rawValue
        switch weight {
        case .regular:
            suffix = ""
        case .ultraLight, .light, .medium, .thin, .bold:
            break
        default:
            // 不支持的weight，默认使用regular
            suffix = ""
        }
        var finalName = baseName
        if suffix.count > 0 {
            finalName = baseName + "-" + suffix
        }
        return CPFFontName(fontName: finalName)
    }
}

extension UIFont {
    class func cpf_helveticaNeue(_ weight: CPFFontName.Weight = .regular, size: CGFloat) -> UIFont {
        return UIFont.cpf_font(.helveticaNeue(weight), size: size)
    }
}

