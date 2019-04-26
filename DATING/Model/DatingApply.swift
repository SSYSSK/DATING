//
//  DatingApply.swift
//  DATING
//
//  Created by 天星 on 17/5/26.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kDatingApplyId               = "apply_id"
let kDatingApplyTime             = "apply_time"
let kDatingApplyDatingI          = "dating_id"
let kDatingApplyComments         = "comments"
let kDatingApplyUser = "user"
class DatingApply: DATUser {
    var applyId: Int?
    var applyTime: String?
    var datingId: Int?
    var comments: String?
    override func update(_ userDict: NSDictionary) {
        super.update(validNSDictionary(userDict[kDatingApplyUser]))
        self.applyId   = validInt(userDict[kDatingApplyId])
        self.applyTime = validString(userDict[kDatingApplyTime])
        self.datingId  = validInt(userDict[kDatingApplyDatingI])
        self.comments  = validString(userDict[kDatingApplyComments])//// 性格特征
    }
}
