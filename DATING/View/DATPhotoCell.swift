//
//  DATPhotoCell.swift
//  DATING
//
//  Created by 天星 on 17/4/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let DATPhotoCellWidth = (kScreenWidth - 40 * kProkScreenWidth) / 3
class DATPhotoCell: UICollectionViewCell {
    var deleteImageBlock:((_ albums : DATUserAlbums?) ->Void)?
    var userAlbums : DATUserAlbums? {
        didSet {
            self.imageView.setImage(fileUrl: validString(userAlbums?.url_thum), placeholder: kIcon_loading)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        imageView.isUserInteractionEnabled = true
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(DATPhotoCell.handleLongpressGesture))
//        tap.minimumPressDuration = 1
        tap.minimumPressDuration=1
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.addGestureRecognizer(tap)
    }
    
    func handleLongpressGesture() {
        deleteImageBlock?(self.userAlbums)
    }
}
