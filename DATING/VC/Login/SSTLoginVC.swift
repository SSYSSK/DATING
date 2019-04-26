//
//  SSTLoginVC.swift
//  sst-ios-po
//
//  Created by Zal Zhang on 12/27/16.
//  Copyright © 2016 po. All rights reserved.
//

import UIKit
let kDATLoginUserNameCell = "DATLoginUserNameCell"


enum LoginType{
    case login
    case loginAgain
}

class SSTLoginVC: UIViewController {

    @IBOutlet weak var passwordTop: NSLayoutConstraint!
   
    @IBOutlet weak var loginAgainView: UIView!
    @IBOutlet weak var loginAgainNameLabel: UILabel!
    @IBOutlet weak var loginAgainPassword: UITextField!
    @IBOutlet weak var loginAgainIconImageView: UIImageView!
    
//    @IBOutlet weak var userNameTableView: UITableView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var deleteUserNameButton: UIButton!
    @IBOutlet weak var deletePasswordButton: UIButton!
    @IBOutlet weak var lookpassword: UIButton!
  
    var backBlock:((_ isLogined: Bool) -> Void)?
    let SegueToRegisterAndForgetPasswordVC = "toRegisterAndForgetPasswordVC"
    
    var logintype : LoginType = .login
    var userName:String = ""
    var users = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏标题的字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: RGBA(255, g: 255, b: 255, a: 1), NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)]
        switch logintype {
        case .login:
            loginAgainView.isHidden = true
            
            self.userNameText.text = validString(getUserDefautsData(kLoginAgain_name))
            self.passwordText.text = validString(getUserDefautsData(kLoginAgain_Paaaword))
            self.userNameText.addTarget(self, action: #selector(SSTLoginVC.textFiledEditChanged(textField:)), for: UIControlEvents.editingChanged)
            self.passwordText.addTarget(self, action: #selector(SSTLoginVC.textFiledEditChanged(textField:)), for: UIControlEvents.editingChanged)
            
            users = getUserNames()
            
            let text:String! = passwordText.text
            let length = text.characters.count
            if (length > 5) {
                loginButton.isEnabled = true
                loginButton.backgroundColor = RGBA(214, g: 62, b: 35, a: 1)
            }else {
                loginButton.isEnabled = false
                loginButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
            }
            if length > 0 {
                deletePasswordButton.isHidden = false
            }else {
                deletePasswordButton.isHidden = true
            }
            
            let textuser:String! = userNameText.text
            let lengthuser = textuser.characters.count
            if lengthuser > 0 {
                deleteUserNameButton.isHidden = false
            }else {
                deleteUserNameButton.isHidden = true
            }

        case .loginAgain:
            loginAgainView.isHidden = false
            
            loginAgainIconImageView.layer.masksToBounds = true
            loginAgainIconImageView.layer.cornerRadius = 0.21 * kScreenWidth / 2
            
            loginAgainNameLabel.text =  validString(biz.user?.nickname)
            loginAgainIconImageView.setImage(fileUrl: validString(biz.user?.main_picts_url_thum), placeholder: kIcon_loading)
        }
        
    }
    
    @IBAction func loginAgainMoreAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: "选择操作方式", preferredStyle: UIAlertControllerStyle.actionSheet)
        let acSure = UIAlertAction(title: "切换帐号", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.loginAgainView.isHidden = true
        }
        let acSure1 = UIAlertAction(title: "注册账号", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.performSegue(withIdentifier: "inputNickName", sender: nil)
        }

        let acSure2 = UIAlertAction(title: "忘记密码", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.performSegue(withIdentifier: "toInputPhone", sender: nil)
        }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
        }
        
        alertVC.addAction(acSure)
        alertVC.addAction(acSure1)
        alertVC.addAction(acSure2)
        alertVC.addAction(acCancel)
        self.present(alertVC, animated: true, completion: nil)

    }
    
    @IBAction func moreAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "", message: "选择操作方式", preferredStyle: UIAlertControllerStyle.actionSheet)
        let acSure = UIAlertAction(title: "注册", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "inputNickName", sender: nil)
        }
        let acSure1 = UIAlertAction(title: "忘记密码", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.performSegue(withIdentifier: "toInputPhone", sender: nil)
        }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
        }
        
        alertVC.addAction(acSure)
        alertVC.addAction(acSure1)
        
        alertVC.addAction(acCancel)
        self.present(alertVC, animated: true, completion: nil)

    }
    
    @IBAction func deleteEvent(_ sender: Any) {
        self.userNameText.text = ""
        loginButton.isEnabled = false
        loginButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
    }
    
    @IBAction func deletePasswordAction(_ sender: Any) {
        self.passwordText.text = ""
        loginButton.isEnabled = false
        loginButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)

    }

    
    @IBAction func showPassword(_ sender: Any) {
        
        passwordText.isSecureTextEntry = !passwordText.isSecureTextEntry
        
    }
    
    // 通知响应方法-限制输入长度
    // MARK: - 通知响应方法
    func textFiledEditChanged(textField:UITextField) {
        if textField == userNameText {
            let text:String! = userNameText.text
            let length = text.characters.count
            if length > 0 {
                deleteUserNameButton.isHidden = false
            }else {
                deleteUserNameButton.isHidden = true
            }
            let ptext:String! = passwordText.text
            let plength = ptext.characters.count
            if (length > 10 && plength >= 6) {
                loginButton.isEnabled = true
                loginButton.backgroundColor = RGBA(214, g: 62, b: 35, a: 1)
            }else {
                loginButton.isEnabled = false
                loginButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
            }
        }
        if textField == passwordText {
            let text:String! = passwordText.text
            let length = text.characters.count
           
            if length > 0 {
                deletePasswordButton.isHidden = false
            }else {
                deletePasswordButton.isHidden = true
            }
            let utext:String! = userNameText.text
            let ulength = utext.characters.count
            
            if (length > 5 && ulength > 10)  {
                loginButton.isEnabled = true
                loginButton.backgroundColor = RGBA(214, g: 62, b: 35, a: 1)
            }else {
                loginButton.isEnabled = false
                loginButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
            }
        }
        
    }

    
    @IBAction func lookPassword(_ sender: Any) {
        loginAgainPassword.isSecureTextEntry = !loginAgainPassword.isSecureTextEntry
    }
    
    @IBAction func clickedLoginWithSSTPurchaserButton(_ sender: Any) {
        SSTProgressHUD.show()
        guard validString(self.userNameText.text) != "" else {
            
            SSTProgressHUD.showErrorWithStatus("请输入用户名")
            return
        }
        guard validString(self.passwordText.text) != "" else {
            SSTProgressHUD.showErrorWithStatus("请输入密码")
            return
        }
        guard isPhoneNumber(phoneNumber: validString(self.userNameText.text)) == true else{
            SSTProgressHUD.showErrorWithStatus("请输入正确的电话号码")
            return
        }
        
        biz.user?.login(userName: validString(userNameText.text), password: validString(passwordText.text)) { data, error in
//            SSTProgressHUD.dismiss()
            if error != nil || data == nil{
                SSTProgressHUD.showErrorWithStatus(validString(validDictionary(error)["message"]))
            }else {
                
                setUserNames(userName: validString(self.userNameText.text))
                
                if let main = gMainNC {
                    for vc in main.childViewControllers {
                        if vc.responds(to: Selector(("resetViewAfterLoginedByAnotherAccount"))) {
                            vc.perform(Selector(("resetViewAfterLoginedByAnotherAccount")))
                        }
                    }
                }
                
                self.dismiss(animated: true, completion: nil)
                self.backBlock?(true)

            }
        }
    }
    @IBAction func loginAgainAction(_ sender: Any) {
        guard validString(self.loginAgainPassword.text) != "" else {
            
            SSTProgressHUD.showErrorWithStatus("请输入密码")
            return
        }
        let button = sender as! UIButton
        button.isEnabled = false
        print("user==\(validString(getUserDefautsData(kLoginAgain_name)))")
        print("loginAgainPassword==\(validString(loginAgainPassword.text))")
        SSTProgressHUD.show()
        biz.user?.login(userName: validString(getUserDefautsData(kLoginAgain_name)), password: validString(loginAgainPassword.text)) { data, error in
            button.isEnabled = true
            SSTProgressHUD.dismiss()
            if error != nil || data == nil{
                
                SSTProgressHUD.showErrorWithStatus("用户名或者密码错误")
            }else {
                
                setUserNames(userName: validString(self.userNameText.text))
                
                self.dismiss(animated: true, completion: nil)
                self.backBlock?(true)
                
            }
        }

    }

}

extension SSTLoginVC:UITextFieldDelegate {
    
    func textField(_ textField:UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        if userNameText == textField {
            
            //限制长度
            let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
            if proposeLength > 11 { return false }
        }
        return true
    }

}

//extension SSTLoginVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: kDATLoginUserNameCell) as! DATLoginUserNameCell
//        cell.nameLabel.text =  self.users[indexPath.row]
//        cell.indexPath = indexPath
//        cell.deleteEventBlock = { indexPath in
//            let userName = self.users[indexPath.row]
//            deleteUserName(userName: userName)
//            self.users = getUserNames()
////            self.userNameTableView.reloadData()
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users.count
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let userName = users[indexPath.row]
//        userNameText.text = userName
//        passwordText.text = ""
////        userNameTableView.isHidden = true
//
//    }
//    
//}
