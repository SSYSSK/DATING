//
//  DATAppointmentDetailUserCell.swift
//  DATING
//
//  Created by 天星 on 17/5/26.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATAppointmentDetailUserCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var user:DatingApply!{
        didSet{
            titleLabel.text = user.nickname
            iconImage.setImage(fileUrl: validString(user.main_picts_url_thum), placeholder: kIcon_loading)
            if let str =  validString(user.applyTime) as? NSString {
                if str.length > 16 {
                    let index = validString(user.applyTime).index(validString(user.applyTime).startIndex, offsetBy: 16)  //索引为从开始偏移5个位置
                    let time = validString(user.applyTime).substring(to: index)
                    timeLabel.text = time
                }else {
                    timeLabel.text = validString(user.applyTime)
                }
            }
            

            
        }
    }
    
    var user2:DATUser?{
        didSet{
            titleLabel.text = user.nickname
            iconImage.setImage(fileUrl: validString(user.main_picts_url_thum), placeholder: kIcon_loading)
            if let str =  validString(user.applyTime) as? NSString {
                if str.length > 16 {
                    let index = validString(user.applyTime).index(validString(user.applyTime).startIndex, offsetBy: 16)  //索引为从开始偏移5个位置
                    let time = validString(user.applyTime).substring(to: index)
                    timeLabel.text = time
                }
                else {
                    timeLabel.text = validString(user.applyTime)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
