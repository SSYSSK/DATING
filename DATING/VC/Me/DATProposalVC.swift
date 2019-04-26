//
//  DATProposalVC.swift
//  DATING
//
//  Created by 天星 on 17/4/8.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
//意见反馈
class DATProposalVC: DATBaseVC {
    let proposalData = DATProposalData()

    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var phoneTextfIELD: UITextField!
    
    @IBAction func commita(_ sender: Any) {
        proposalData.feedbackAddnew(text: validString(contentTextField.text), phone: validString(phoneTextfIELD.text)) { (data, error) in
            if error != nil {
                SSTProgressHUD.showErrorWithStatus(validString(error))
                //                SSTToastView.showError(validString(error))
            }else {
                SSTProgressHUD.showSuccessWithStatus("已收到您的宝贵建议！非常感谢您的支持")
                //                SSTToastView.showSucceed("已收到您的宝贵建议！非常感谢您的支持")
                TaskUtil.delayExecuting(1, block: {
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
