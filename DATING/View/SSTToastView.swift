//
//  SSTToastView.swift
//  sst-ios
//
//  Created by Amy on 2016/12/26.
//  Copyright © 2016年 SST. All rights reserved.
//

import UIKit

class SSTToastView: UIView {

    let bgColor = UIColor(red: 152/255.0, green: 152/255.0, blue: 152/255.0, alpha: 1)
    let textColor = UIColor.white
    var applicationKeyWindow: UIWindow!
    var msgLabel: UILabel!
    var iconImage: UIImageView!
    
    static var appWindow:UIWindow! {
        get {
            var applicationKeyWindow:UIWindow! = nil
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                if window.windowLevel == UIWindowLevelNormal {
                    applicationKeyWindow = window
                    break
                }
            }
            if applicationKeyWindow == nil {
                return nil
            }
            return applicationKeyWindow
        }
    }

    static let sharedInstance = SSTToastView()
    init() {
        super.init(frame: CGRect(x: 0, y: -64, width: kScreenWidth, height: 40))
        
        iconImage = UIImageView(frame: CGRect(x: 20, y: 30, width: 20, height: 20))
        iconImage.image = UIImage(named: "icon_success")
        self.addSubview(iconImage)
        
        msgLabel = UILabel(frame: CGRect(x: iconImage.frame.origin.x + iconImage.frame.width + 5, y: iconImage.frame.origin.y + 5, width: kScreenWidth - iconImage.frame.origin.x - iconImage.frame.width - 10, height: 30))
        msgLabel.textColor = textColor
        msgLabel.numberOfLines = 0
        msgLabel.font = UIFont.systemFont(ofSize: 13)
        msgLabel.lineBreakMode = .byWordWrapping
        msgLabel.textAlignment = .left
        self.addSubview(msgLabel)

        self.backgroundColor = bgColor
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(SSTToastView.dismissSelf))
        self.addGestureRecognizer(tapAction)
        self.alpha = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func showSucceed(_ msg: String) {
        self.show(msg, icon: "icon_success", top: 0)
    }
    
    class func showError(_ msg: String) {
        var message = msg
        if message.characters.count <= 0 {
            message = kBadConnectedMessage
        }
        if biz.ntwkAccess.networkIsAvailable {
            self.show(message, icon: "icon_failed", top: 0)
        }
    }
     
    class func showErrorNetworkConnect(_ msg: String) {
        var message = msg
        if message.characters.count <= 0 {
            message = kBadConnectedMessage
        }
        self.show(message, icon: "icon_wifi", top: 0)
    }
    
    class func show(_ msg:String, icon: String, top:CGFloat) {
        // get window
        guard let win = appWindow  else {
            return
        }
        win.addSubview(SSTToastView.sharedInstance)
        
        SSTToastView.sharedInstance.msgLabel.text = msg
        let maxSize = CGSize(width: kScreenWidth - SSTToastView.sharedInstance.msgLabel.frame.origin.x , height: kScreenHeight * 0.8)
        let expectedHeight = msg.sizeByWidth(font: 13, width: maxSize.width).height + 20
        
        SSTToastView.sharedInstance.iconImage.frame = CGRect(x: 20, y: 10 + (expectedHeight + 15 - 20 )/2,  width: 20, height: 20)
        
        SSTToastView.sharedInstance.msgLabel.frame = CGRect(x: SSTToastView.sharedInstance.iconImage.frame.origin.x + SSTToastView.sharedInstance.iconImage.frame.width + 5, y: 10,  width: maxSize.width, height: expectedHeight + 15)
        
        SSTToastView.sharedInstance.frame = CGRect(x: 0, y: -64, width: kScreenWidth, height: expectedHeight + 25)
        SSTToastView.sharedInstance.iconImage.image = UIImage(named: icon)
        
        //去掉所有的动画
        SSTToastView.sharedInstance.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.transitionFlipFromTop, animations: { () -> Void in
            var frame = SSTToastView.sharedInstance.frame
            frame.origin.y = 0
            SSTToastView.sharedInstance.frame = frame
            SSTToastView.sharedInstance.alpha = 1
        }) { (finished) -> Void in
            let delay = 3 * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time) {
                SSTToastView.dismiss()
            }
        }
    }

    class func dismiss() {
        if SSTToastView.sharedInstance.alpha == 1 {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.transitionFlipFromBottom, animations: { () -> Void in
                var frame = SSTToastView.sharedInstance.frame
                frame.origin.y = -64
                SSTToastView.sharedInstance.frame = frame
                SSTToastView.sharedInstance.alpha = 0
            }) { (finished) -> Void in
                
            }
        }
    }

    func dismissSelf() {
        SSTToastView.dismiss()
    }
}
