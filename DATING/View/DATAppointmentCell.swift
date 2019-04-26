//
//  DATAppointmentCell.swift
//  DATING
//
//  Created by 天星 on 17/5/26.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

import UIKit
enum AppointmentType {
    case zan
    case fuyue
}
class DATAppointmentCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sexImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zanLabel: UILabel!
    @IBOutlet weak var shouCang: UILabel!
    @IBOutlet weak var eventView: UIView!
    
    var datingOrApply:((_ type: AppointmentType) ->Void)?
    
    var userDetailBlack:((_ appointment:DATAppointment)->Void)?
    
    var hiddlenZanView:(() ->Void)?
    
    var eventViewRect = CGRect()
    
    override func awakeFromNib() {
         eventViewRect = self.eventView.frame
    }
    
    var appointment:DATAppointment? {
        didSet{
            titleLabel.text = appointment?.title

            timeLabel.text = validString(appointment?.datingTime)
            
            iconImageView.setImage(fileUrl: validString(appointment?.main_picts_url_thum), placeholder: kIcon_loading)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(DATAppointmentCell.iconAction))
            iconImageView.addGestureRecognizer(tap)
            iconImageView.isUserInteractionEnabled = true
            
            if appointment?.psex == 0 {
                sexImageView.image = UIImage(named: "ic_gender_male")
               
                sexImageView.frame = CGRect(x: 166.5, y: 49, width: 64, height: 16)
            }else if appointment?.psex == 1{
                sexImageView.image = UIImage(named: "ic_gender_female")
                sexImageView.frame = CGRect(x: 126.5, y: 49, width: 16, height: 16)
            }else {
                sexImageView.frame = CGRect(x: 166.5, y: 49, width: 32, height: 16)
                sexImageView.image = UIImage(named: "ic_gender_nolimit")
            }
            addressLabel.text = appointment?.address
            zanLabel.text = validString(appointment?.upNum)
            shouCang.text = validString(appointment?.applyNum)
        }
    }

    func iconAction(){
        if appointment != nil {
            userDetailBlack?(appointment!)
        }
    }
    
    @IBAction func zanEvent(_ sender: Any) {
        self.datingOrApply?(.zan)

        UIView.animate(withDuration: 0.3, animations: {
            
            self.eventView.frame = CGRect(x: self.eventViewRect.origin.x + self.eventViewRect.size.width, y: self.eventViewRect.origin.y, width: 0, height: self.eventViewRect.size.height)
            self.eventView.alpha = 0
        }) { (data) in
            self.eventView.isHidden = true
        }
    }
    @IBAction func fuyueEvent(_ sender: Any) {
        self.datingOrApply?(.fuyue)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.eventView.frame = CGRect(x: self.eventViewRect.origin.x + self.eventViewRect.size.width, y: self.eventViewRect.origin.y, width: 0, height: self.eventViewRect.size.height)
            self.eventView.alpha = 0
        }) { (data) in
            self.eventView.isHidden = true
        }

    }

    
    @IBAction func showV(_ sender: Any) {
        self.hiddlenZanView?()
        self.showView(sender)
    }
    @IBAction func showView(_ sender: Any) {
        if eventView.isHidden == true {
            self.eventView.isHidden = false
            self.eventView.alpha = 0
            self.eventView.frame = CGRect(x: self.eventViewRect.origin.x, y: self.eventViewRect.origin.y, width: 0, height: self.eventViewRect.size.height)
            UIView.animate(withDuration: 0.3, animations: {
                self.eventView.alpha = 1
                self.eventView.frame = CGRect(x: self.eventViewRect.origin.x, y: self.eventViewRect.origin.y, width: self.eventViewRect.size.width, height: self.eventViewRect.size.height)
            }) { (data) in
            }
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                let rect = self.eventView.frame
                self.eventView.frame = CGRect(x: rect.origin.x + rect.size.width, y: rect.origin.y, width: 0, height: rect.size.height)
                self.eventView.alpha = 0
            }) { (data) in
                self.eventView.isHidden = true
            }
        }
    }
}
