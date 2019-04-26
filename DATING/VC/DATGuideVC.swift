//
//  DATGuideVC.swift
//  DATING
//
//  Created by 天星 on 17/3/30.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATGuideVC: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        biz.user = DATUser()
        biz.user?.birtyday = "1990-12-11" 
        
        let serverInfo = DATServiceInfo()
        print(validString(biz.config?.slogan))
        
        
        serverInfo.uploadAppInfo { (data, error) in
            debugPrint("=====")
        }
        print(validString(getUserDefautsData(kSlogan)))
        self.messageLabel.text = validString(getUserDefautsData(kSlogan))
        let config = DATConfig()
        config.getConfig { (data, error) in
            print(validString(biz.config?.slogan))
            self.messageLabel.text = validString(biz.config?.slogan)
            TaskUtil.delayExecuting(1) {
                if error == nil {
                    let mainTabbarC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(DATMainVC.classForCoder())") as! DATMainVC
                    UIApplication.shared.keyWindow?.rootViewController = mainTabbarC
                }else {
                    print("guide页面请求失败\(error)")
                    let mainTabbarC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(DATMainVC.classForCoder())") as! DATMainVC
                    UIApplication.shared.keyWindow?.rootViewController = mainTabbarC
                }

            }
        }
        
        TaskUtil.delayExecuting(1) {
            let mainTabbarC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(DATMainVC.classForCoder())") as! DATMainVC
            UIApplication.shared.keyWindow?.rootViewController = mainTabbarC
        }
       
    }
}
