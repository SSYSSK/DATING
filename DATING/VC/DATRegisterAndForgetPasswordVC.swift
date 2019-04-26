//
//  DATRegisterAndForgetPasswordVC.swift
//  DATING
//
//  Created by 天星 on 17/6/14.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
enum type {
    case regist
    case forgetPassword
}
class DATRegisterAndForgetPasswordVC: DATBaseVC {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPassworldTextField: UITextField!

    
    var typet:type = .forgetPassword
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch typet {
        case .regist:
            self.title = "注册"
        case .forgetPassword:
            self.title = "忘记密码"

        }
    }
    
    @IBAction func getCode(_ sender: Any) {
        biz.user?.getCode(phone: validString(phoneTextField.text)) { data, error in
            SSTProgressHUD.dismiss()
            if error == nil {
                SSTProgressHUD.showSuccessWithStatus("验证码已发送")
            }else {
                SSTProgressHUD.showErrorWithStatus("获取验证码失败")
            }
        }
    }
    
    @IBAction func registerEvent(_ sender: Any) {
        guard validString(self.passwordTextField.text) == validString(self.repeatPassworldTextField.text) else {
            SSTToastView.showError("两次输入密码不一样")
            return
        }
        switch typet {
        case .regist:
            biz.user?.registerEvent(phone: validString(phoneTextField.text), password: validString(passwordTextField.text), code: validString(codeTextField.text)) { data, error in
                SSTProgressHUD.dismiss()
                if error == nil {
                    SSTProgressHUD.showSuccessWithStatus("注册成功")
                    self.navigationController?.popViewController(animated: true)
                }else {
                    SSTProgressHUD.showErrorWithStatus("注册失败")
                }
            }

        case .forgetPassword:
            biz.user?.forgetPasswordEvent(phone: validString(phoneTextField.text), password: validString(passwordTextField.text), code: validString(codeTextField.text)) { data, error in
                SSTProgressHUD.dismiss()
                if error == nil {
                    SSTProgressHUD.showSuccessWithStatus("修改密码成功")
                    self.navigationController?.popViewController(animated: true)
                }else {
                    SSTProgressHUD.showErrorWithStatus("修改密码失败")
                }
            }

        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
