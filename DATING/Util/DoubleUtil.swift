//
//  DoubleUtil.swift
//  sst-ios-po
//
//  Created by Zal Zhang on 12/28/16.
//  Copyright © 2016 po. All rights reserved.
//

import UIKit

extension Double {
    
    func format(f: String = ".2") -> String {
        return String(format: "$%\(f)f", self)
    }
    
    func formatC(f: String = ".2") -> String {
        return String(format: "$%\(f)f", self)
    }
    
    func formatCWithoutCurrency(f: String = ".2") -> String {
        return String(format: "%\(f)f", self)
    }
    
    func equalZero() -> Bool {
        if self < 0.000001 {
            return true
        } else {
            return false
        }
    }
    
}
