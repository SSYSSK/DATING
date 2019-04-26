//
//  DATGiftModel.swift
//  DATING
//
//  Created by 天星 on 17/8/10.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kGiftID = "giftId"
let kgiftName = "name"
let kGiftIcon = "code"
let kGiftPrice = "coin_qty"
let kGiftCNT = "gift_cnt"
class DATGiftModel: BaseModel {
    var giftId:Int?
    var giftName:String?
    var giftIcon:String?
    var giftCnt:Int?
    var price:Int?
    func update(_ giftDict: NSDictionary) -> DATGiftModel {
        let gift = DATGiftModel()
        gift.giftId = validInt(giftDict[kGiftID])
        gift.giftName = validString(giftDict[kgiftName])
        gift.price = validInt(giftDict[kGiftPrice])
        gift.giftIcon = validString(giftDict[kGiftIcon])
        gift.giftCnt = validInt(giftDict[kGiftCNT])
        return gift
    }

}
