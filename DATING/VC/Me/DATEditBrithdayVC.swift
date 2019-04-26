//
//  DATEditBrithdayVC.swift
//  DATING
//
//  Created by 天星 on 17/4/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATEditBrithdayVC: DATBaseVC {

    @IBOutlet weak var britydayLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var brithday = ""
    
    var chooseBrithdayBlock:((_ date: String) ->Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = Locale(identifier: "zh_CN")
        britydayLabel.text = brithday
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChange(_ sender: Any) {
        
        britydayLabel.text = datePicker.date.formatyyMMdd()
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        if let block = chooseBrithdayBlock  {
            block(validString(datePicker.date.formatyyMMdd()))
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
