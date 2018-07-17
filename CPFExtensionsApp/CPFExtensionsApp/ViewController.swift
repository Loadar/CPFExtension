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
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateBaged(_:)), userInfo: nil, repeats: true)
    }
    
    @objc private func updateBaged(_ timer: Timer) {
        count += 1
        testView.cpf_updateBadge(with: count)
        
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

