//
//  SSTNickNameVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/6/19.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class SSTNickNameVC: DATBaseVC {
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var user = DATUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
        nickNameTextField.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
    }
    
    func textChange(_ textField:UITextField) {

        if (textField.text?.characters.count)!>0 {
                        nextButton.isEnabled = true
                        nextButton.backgroundColor = RGBA(214, g: 62, b: 35, a: 1)
                    }else {
                        nextButton.isEnabled = false
                        nextButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
                    }
    }

    @IBAction func nextAction(_ sender: Any) {
        user.nickname = nickNameTextField.text
        performSegueWithIdentifier(.SegueToImageBritydayVC, sender: nil)
    }
    @IBAction func serviceAction(_ sender: Any) {
        performSegueWithIdentifier(.SegueToServiceVC, sender: nil)
    }
}

// MARK: -- segue delegate
extension SSTNickNameVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToImageBritydayVC       = "toImageBritydayVC"
        case SegueToServiceVC       = "toServiceVC"
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToImageBritydayVC:

        let destVC = segue.destination as! DATImageBrithdayVC
        destVC.user = user
        case .SegueToServiceVC:
            print("--")
        }
    }
}

