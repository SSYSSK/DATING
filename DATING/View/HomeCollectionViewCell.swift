//
//  HomeCollectionViewCell.swift
//  DATING
//
//  Created by 天星 on 17/3/31.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let HomeCollectionViewCellWidth = (kScreenWidth - 37 * kProkScreenWidth) / 3
class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ageAddress: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true;
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.cornerRadius = HomeCollectionViewCellWidth * 0.8 / 2 //变圆形
    }
    
    var user:DATUser? {
        didSet{
           ageAddress.text = "\(validString(user?.age))岁 \(validString(user?.city))"
            nameLabel.text = validString(user?.nickname)
            imageView.setImage(fileUrl: validString(user?.main_picts_url_thum), placeholder: kIcon_loading) 
        }
    }

}
