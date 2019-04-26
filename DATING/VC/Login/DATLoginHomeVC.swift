//
//  DATLoginHomeVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/6/19.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
//toRegisVC
//toLoginVC
class DATLoginHomeVC: DATBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        performSegueWithIdentifier(.SegueToLoginVC, sender: nil)
    }

    @IBAction func regisAction(_ sender: Any) {
        
        performSegueWithIdentifier(.SegueToRegisVC, sender: nil)
    
    }

}
// MARK: -- segue delegate
extension DATLoginHomeVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToRegisVC        = "toRegisVC"
        case SegueToLoginVC         = "toLoginVC"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
