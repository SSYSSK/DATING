//
//  SSTSearchTextField.swift
//  sst-ios-po
//
//  Created by Zal Zhang on 12/27/16.
//  Copyright © 2016 po. All rights reserved.
//

import UIKit

class SSTSearchTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+13, y: bounds.origin.y, width: bounds.size.width-55, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+13, y: bounds.origin.y, width: bounds.size.width-55, height: bounds.size.height)
    }

}
