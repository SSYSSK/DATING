//
//  SSTEmptyView.swift
//  sst-ios
//
//  Created by Zal Zhang on 5/5/17.
//  Copyright © 2017 ios. All rights reserved.
//

import UIKit

class SSTDataEmptyView: UIView {
    
    var buttonClick: ( () -> Void)?

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    func setData(imgName: String = "关注列表为空", msg: String = "No_Task", buttonTitle: String = "刷新", buttonVisible: Bool = false) {
        imgV.image = UIImage(named: imgName)
        msgLabel.text = msg
        tryAgainButton.setTitle(buttonTitle, for: .normal)
        
        if buttonVisible {
            tryAgainButton.isHidden = false
        } else {
            tryAgainButton.isHidden = true
        }
    }
    
    @IBAction func clickedButton(_ sender: Any) {
        buttonClick?()
    }
    
}
