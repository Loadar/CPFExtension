//
//  ViewController.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/15.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let weights: [CPFFontName.Weight: String] = [.ultraLight: "ultraLight", .thin: "thin", .light: "light", .regular: "regular", .medium: "medium", .semibold: "semibold", .bold: "bold", .heavy: "heavy", .black: "black"]
        
        for (aWeight, aText) in weights {
            print(aText, UIFont.cpf_font(name: .pingFang(aWeight), size: 12.0))
            print(aText, UIFont.cpf_font(name: .helveticaNeue(aWeight), size: 12.0))

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
        var suffix = self.suffix(of: weight)
        switch weight {
        case .regular:
            suffix = ""
        case .ultraLight, .light, .medium, .thin, .bold:
            suffix = self.suffix(of: weight)
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

