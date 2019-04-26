//
//  DATLoginUserNameCell.swift
//  DATING
//
//  Created by 林丽萍 on 2017/7/9.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATLoginUserNameCell: UITableViewCell {
    var indexPath = IndexPath()
    var deleteEventBlock:((_ indexPath:IndexPath) ->Void)?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteEvent(_ sender: Any) {
        self.deleteEventBlock?(indexPath)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
