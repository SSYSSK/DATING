//
//  ChoseBrithdayView.swift
//  DATING
//
//  Created by 林丽萍 on 2017/6/19.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class ChoseBrithdayView: UIView {
    
    @IBOutlet weak var datePateView: UIDatePicker!

    @IBOutlet weak var bgView: UIView!
    
    var hiddlenActionBlock:((_ date: String) ->Void)?
   
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChoseBrithdayView.hiddlenAction))
        bgView.addGestureRecognizer(tap)
         
//         [self.datePickerV setDatePickerMode:UIDatePickerModeDate];
    }
    
    func hiddlenAction() {
        
        let date = datePateView.date
        hiddlenActionBlock?(date.formatyyMMdd())
        self.removeFromSuperview()
    }
    @IBAction func enterAction(_ sender: Any) {
        self.hiddlenAction()
    }
    
}
