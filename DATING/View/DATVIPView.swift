//
//  DATVIPView.swift
//  DATING
//
//  Created by 天星 on 17/7/7.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATVIPView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    var enterEventBlock:(() ->Void)?
    @IBAction func cancelEvent(_ sender: Any) {
        self.removeFromSuperview()
    }

    @IBAction func enterEvent(_ sender: Any) {
        enterEventBlock?()
        self.removeFromSuperview()
    }
}
