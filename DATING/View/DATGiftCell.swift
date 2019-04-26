//
//  DATGiftCell.swift
//  DATING
//
//  Created by 天星 on 17/8/10.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATGiftCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 4//设置那个圆角的有多圆
        bgView.layer.borderWidth = 0.5//设置边框的宽度，当然可以不要
        bgView.layer.borderColor = RGBA(255, g: 114, b: 86, a: 0.5).cgColor//设置边框的颜色
        bgView.layer.masksToBounds = true//设为NO去试试
    }
    
    var gift:DATGiftModel?{
        didSet{
            imageView.image = UIImage(named: validString(gift?.giftIcon))
            titleLabel.text = "\(validString(gift?.giftName))"
            priceLabel.text = "\(validString(gift?.price))金币 * \(validString(gift?.giftCnt))"
        }
    }

}
