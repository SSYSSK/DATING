//
//  DatInputNewPassword.swift
//  DATING
//
//  Created by 天星 on 17/9/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DatInputNewPassword: DATBaseVC {
    var phone = ""
    
    @IBOutlet weak var messagelabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var getCodeButton: UIButton!
    @IBOutlet weak var massgeL: UILabel!
    private var countdownTimer: Timer?
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    private var remainingSeconds: Int = 0 {
        willSet {
            getCodeButton.setTitle("重新获取\(newValue)秒", for: .normal)
            if newValue <= 0 {
                getCodeButton.setTitle("获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
                getCodeButton.setTitleColor(UIColor.darkGray, for: .normal)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                getCodeButton.setTitleColor(UIColor.blue, for: .normal)
            }
            getCodeButton.isEnabled = !newValue
        }
    }
    
    
    @objc private func updateTime() {
        remainingSeconds -= 1
    }
    
    @IBAction func lookPassword(_ sender: Any) {
        newPasswordTextField.isSecureTextEntry = !newPasswordTextField.isSecureTextEntry
    }
    @IBAction func getCodeAction(_ sender: Any) {
        
        
        biz.user?.getCode(phone: phone) { data, error in
            SSTProgressHUD.dismiss()
            if error == nil {
                SSTProgressHUD.showSuccessWithStatus("验证码已发送")
            }else {
                SSTProgressHUD.showErrorWithStatus("获取验证码失败")
            }
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
        if validString(newPasswordTextField.text) != "" &&  validString(codeTextField.text) != ""  {
            var operation:[String:Any] = [String:Any]()
            var param:[String:Any] = [String:Any]()
            
            operation["module"] = "sms"
            operation["action"] = "tele_no_pwd_forget"
            
            var sms:[String:Any] = [String:Any]()
            
            sms["login_encrypted_pwd"] = validString(newPasswordTextField.text).MD5()
            sms["tele_no"] = phone
            sms["valid_code"] = validString(codeTextField.text).MD5()
            
            param["sms"] = sms
            
            biz.forgetPassword(param: param, operation: operation) { (data, error) in
                if error == nil {
                     _ = self.navigationController?.popToRootViewController(animated: true)
                }else {
                    SSTProgressHUD.showErrorWithStatus("修改密码失败")
                }
            }

        }else {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isCounting = true//开启倒计时
        messagelabel.text = "验证码已发送到\(validString(phone))"
    }


    
}
