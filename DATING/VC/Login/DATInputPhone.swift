//
//  DATInputPhone.swift
//  DATING
//
//  Created by 天星 on 17/9/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATInputPhone: DATBaseVC {
    
    @IBOutlet weak var phoneTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextAction(_ sender: Any) {
        
        guard isPhoneNumber(phoneNumber: validString(self.phoneTextField.text)) == true else{
            SSTProgressHUD.showErrorWithStatus("请输入正确的电话号码")
            return
        }
        
        if validString(phoneTextField.text) != "" {
            let alertController = UIAlertController(title: "请确认当前手机号",
                                                    message: "\(validString(phoneTextField.text))", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                
                // 验证手机是否注册
                biz.user?.phoneIsResit(phone: validString(self.phoneTextField.text), { (data, error) in
                    print("data==\(data)")
                    print("error==\(error)")

                })
                
//                biz.user?.getCode(phone: validString(self.phoneTextField.text)) { data, error in
//                   self.performSegue(withIdentifier: SegueIdentifier.SegueToInputNewPassword.rawValue, sender: nil)
//                }
                
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }else {
            SSTProgressHUD.showErrorWithStatus("请输入手机号码")
        }
        
    }
}
// MARK: -- segue delegate
extension DATInputPhone: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToInputNewPassword         = "toInputNewPassword"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToInputNewPassword:
            let destVC = segue.destination as! DatInputNewPassword
            destVC.phone = validString(phoneTextField.text)
        }
    }
}
