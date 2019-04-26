//
//  DATRegisterAndForgetPasswordVC.swift
//  DATING
//
//  Created by 天星 on 17/6/14.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATRegisterAndForgetPasswordVC: DATBaseVC {

    @IBOutlet weak var messagelabel: UILabel!

    @IBOutlet weak var condeTextField: UITextField!
    
    var user = DATUser()
    
    var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.title = "注册"
        messagelabel.text = "验证码已发送到:\(validString(user.phone))"
    }


    @IBAction func registerEvent(_ sender: Any) {
        
        
        guard validString(self.condeTextField.text) != "" else {
            SSTProgressHUD.showErrorWithStatus("请输入验证码")
            return
        }
        
        SSTProgressHUD.show()
        
            
        biz.user?.registerEvent(user: user, image: image, code: validString(condeTextField.text), { (data, error) in
//            SSTProgressHUD.dismiss()
            if error == nil {
                SSTProgressHUD.showSuccessWithStatus("注册成功")
                _ = self.navigationController?.popToRootViewController(animated: true)
            }else {

                SSTProgressHUD.showErrorWithStatus("注册失败")
            }
        })

       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
