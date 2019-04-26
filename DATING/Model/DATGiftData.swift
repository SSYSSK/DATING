//
//  DATGiftData.swift
//  DATING
//
//  Created by 天星 on 17/8/10.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kGifts = "gifts"
class DATGiftData: BaseModel {
    var gifts = [DATGiftModel]();
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    func update(_ dict:  Dictionary<String,Any>) {
        var giftsT = [DATGiftModel]()
        let gifts = validArray(dict[kGifts])
        for giftDict in gifts {
            let gift = DATGiftModel().update(validNSDictionary(giftDict))
            giftsT.append(gift)
        }
        self.gifts = giftsT
    }
    
    func getGiftByUser(){
        
        var operation:[String:Any] = [String:Any]()
        
        operation["module"] = "gift"
        operation["action"] = "gift_receive"
        
        let device:[String:Any] = [
            "device_no": kDevice_no
        ]
        
        var param:[String:Any] = [String:Any]()
         param["device"] = device

        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        param["user"] = user

        biz.getGiftByUser(param: param, operation: operation) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
                self.delegate?.refreshUI(self)
                
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
    func getGiftList(){
        var operation:[String:Any] = [String:Any]()
        
        operation["module"] = "gift"
        operation["action"] = "gift_list_get"
        
        let param:[String:Any] = [String:Any]()
        
        biz.getGiftList(param: param, operation: operation) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
                self.delegate?.refreshUI(self)
                biz.giftData = self
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
}
