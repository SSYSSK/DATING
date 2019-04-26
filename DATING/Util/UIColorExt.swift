//
//  UIColorExt.swift
//  sst-ios
//
//  Created by Zal Zhang on 1/13/17.
//  Copyright © 2017 ios. All rights reserved.
//

import UIKit

let systemColor = UIColor(red: 142/255.0, green: 144/255.0, blue: 243/255.0, alpha: 1)

extension UIColor {
    
    class func setAppFontColor_Blue() -> UIColor {
        return UIColor(red: 69 / 255.0, green: 132 / 255.0, blue: 244 / 255.0, alpha: 1)
    }
    
    class func colorWithCustom(_ r: CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithCustom(r, g: g, b: b)
    }
    
}
