//
//  SSTProgressHUD.swift
//  sst-ios
//
//  Created by MuChao Ke on 16/10/19.
//  Copyright © 2016年 SST. All rights reserved.
//

import UIKit
//import SVProgressHUD

class SSTProgressHUD {
    
    class func setup() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor(red: 39 / 255.0, green: 39 / 255.0, blue: 39 / 255.0, alpha: 0.9))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }
    
    class func showErrorWithStatus(_ error: String) {
        SVProgressHUD.showError(withStatus: error)
    }
    
    class func showSuccessWithStatus(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func showWithStatus(_ message:String) {
        SVProgressHUD.show(withStatus: message)
    }
    
    class func showInfoWithStatus(_ message:String) {
        SVProgressHUD.showInfo(withStatus: message)
    }
    
    class func showInfoWithStatusOnlyForDEV(_ message:String) {
        #if DEV
        SVProgressHUD.showInfo(withStatus: "\(message)\n --- only show this on DEV environment.")
        #endif
    }
    
    class func setMinimumDismissTimeInterval(_ Time: TimeInterval) {
        SVProgressHUD.setMinimumDismissTimeInterval(Time)
    }
}
