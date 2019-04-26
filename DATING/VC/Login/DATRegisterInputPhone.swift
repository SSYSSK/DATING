//
//  DATRegisterInputPhone.swift
//  DATING
//
//  Created by 天星 on 17/9/12.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATRegisterInputPhone: DATBaseVC {
    var user = DATUser()
    var image = UIImage()
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func lookPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }

    @IBAction func nextAction(_ sender: Any) {
        guard validString(phoneTextField.text) != "" else {
            SSTProgressHUD.showErrorWithStatus("请输入手机号")
            return
        }
        guard validString(passwordTextField.text) != "" else {
            SSTProgressHUD.showErrorWithStatus("请输入密码")
            return
        }
        let text:String! = passwordTextField.text
        let length = text.characters.count
        guard length >= 6 else {
            SSTProgressHUD.showErrorWithStatus("密码不能少于6位")
            return
        }
        let alertController = UIAlertController(title: "请确认当前手机号\n\(validString(phoneTextField.text))",
                                                message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            
            self.user.phone = validString(self.phoneTextField.text)
            self.user.login_plain_pwd = validString(self.passwordTextField.text)
            
            
            biz.user?.phoneIsResit(phone: validString(self.phoneTextField.text), { (data, error) in
                print(data)
                print(error)
            })
            
//            biz.user?.getCode(phone: validString(self.phoneTextField.text)) { data, error in
//                SSTProgressHUD.dismiss()
//                if error == nil {
//                    SSTProgressHUD.showSuccessWithStatus("验证码已发送")
//                    TaskUtil.delayExecuting(1, block: {
//                        self.performSegue(withIdentifier: SegueIdentifier.SegueToRegisResultVC.rawValue, sender: nil)
//                    })
//                }else {
//                    SSTProgressHUD.showErrorWithStatus("获取验证码失败")
//                }
//            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: -- segue delegate
extension DATRegisterInputPhone: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToRegisResultVC         = "toRegisResultVC"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToRegisResultVC:
            let destVC = segue.destination as! DATRegisterAndForgetPasswordVC
            destVC.user = self.user
            destVC.image = self.image
        }
    }
}
