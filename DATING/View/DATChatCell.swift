
//
//  DATChatCell.swift
//  DATING
//
//  Created by 天星 on 17/4/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChatCell: UITableViewCell {

    @IBOutlet weak var iconIageView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
