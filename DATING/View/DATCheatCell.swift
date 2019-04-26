//
//  DATCheatCell.swift
//  DATING
//
//  Created by 天星 on 17/8/9.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
import CoreGraphics

class DATCheatCell: UITableViewCell {

    @IBOutlet weak var ICON: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var user: DATUser? {
        didSet {

            do {
                let urlRequest = try URLRequest(url:  validString(user?.main_picts_url_thum), method: .get, headers: nil)
                self.ICON.af_setImage(withURLRequest: urlRequest, placeholderImage: UIImage(named:kIcon_loading), filter: nil, progress: nil, progressQueue: .main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion: { (data) in
                    if self.user?.online == false {
                        self.ICON.image = self.ICON.image?.grayImage(image: self.ICON.image!)
                    }else {
                        self.ICON.setImage(fileUrl: validString(self.user?.main_picts_url_thum), placeholder: kIcon_loading)
//                        if self.user?.login_name ==  "c011" {
//                            self.ICON.image = self.ICON.image?.grayImage(image: self.ICON.image!)
//                        }
//
                    }
                })
                } catch {
                    
                }
            
            nameLabel.text = validString(user?.nickname)
        }
    }

}
