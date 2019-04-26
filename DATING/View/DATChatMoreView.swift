//
//  DATChatMoreView.swift
//  DATING
//
//  Created by 林丽萍 on 2017/9/27.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChatMoreView: UIView {
    
    var buttonActionBlock:((_ type: String) ->Void)?

    @IBAction func clearEvent(_ sender: Any) {
        self.buttonActionBlock?("1")
    }

    @IBAction func jubaoUser(_ sender: Any) {
        self.buttonActionBlock?("2")
    }
}
