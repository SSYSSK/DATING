//
//  DATReportVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/9/27.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATReportVC: DATBaseVC {

    @IBOutlet weak var restion: UIButton!
    
    @IBOutlet weak var contentTextField: UITextField!
    
//    var userId = ""
    var user = DATUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func choseRestionAction(_ sender: Any) {
        performSegueWithIdentifier(.SegueToTableView, sender: nil)
    }

    @IBAction func commitAction(_ sender: Any) {
        user.restion(user: user, content: validString(contentTextField.text), subject: validString(restion.titleLabel?.text)) { (data, error) in
            if error != nil {
                SSTProgressHUD.showSuccessWithStatus("投诉成功，我们验证之后会严惩")
                TaskUtil.delayExecuting(1, block: { 
                    _ = self.navigationController?.popViewController(animated: true)
                })
               
            }else{
                SSTProgressHUD.showErrorWithStatus("投诉失败，请联系客服人员")
            }
        }
    }
}
// MARK: -- segue delegate
extension DATReportVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToTableView         = "toTableView"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToTableView:
            debugPrint("-----")
            let destVC = segue.destination as! DATEditInfoTableVC
            destVC.editType = .resionType
            destVC.chooseInfoBlock = { [unowned self] (info) in
                self.restion.setTitle(info, for: UIControlState.normal)
            }
        }
    }
}
