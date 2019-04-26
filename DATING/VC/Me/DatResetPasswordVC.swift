//
//  DatResetPasswordVC.swift
//  DATING
//
//  Created by 天星 on 17/5/12.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DatResetPasswordVC: DATBaseTVC {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var resetNewPassword: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none;
        textLabel.text = "为您的账号：\(validString(biz.user?.login_name)) 创建登录密码,以便保护您的个人隐私及方便您在其它设备上登录该账号"
    }
    @IBAction func resetNewPasswordShow(_ sender: Any) {
        resetNewPassword.isSecureTextEntry = !resetNewPassword.isSecureTextEntry
    }

    @IBAction func newPasswordShow(_ sender: Any) {
        newPassword.isSecureTextEntry = !newPassword.isSecureTextEntry
    }
    @IBAction func oldPasswordShow(_ sender: Any) {
        oldPassword.isSecureTextEntry = !oldPassword.isSecureTextEntry
    }
    
    @IBAction func commit(_ sender: Any) {
        guard validString(oldPassword.text).isNotEmpty else {
            SSTProgressHUD.showErrorWithStatus("请输入原密码")
            return
        }
        guard validString(newPassword.text).isNotEmpty else {
            SSTProgressHUD.showErrorWithStatus("请输入新密码")
            return
        }
        guard validString(newPassword.text) == validString(resetNewPassword.text) else {
            SSTProgressHUD.showErrorWithStatus("两次新密码输入不一样")
            return
        }
        
        biz.user?.changePassword(oldPassword: validString(oldPassword.text).MD5(), newPassword: validString(newPassword.text).MD5(), { (data, error) in
            if error != nil {
                SSTProgressHUD.showErrorWithStatus(validString(validDictionary(error)["message"]))
            }else {
                SSTProgressHUD.showSuccessWithStatus("修改密码成功！")
                _ = self.navigationController?.popViewController(animated: true)
            }
        })
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
