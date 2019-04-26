//
//  DATMessage.swift
//  DATING
//
//  Created by 天星 on 17/5/4.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATMessage: NSObject {
    var from:String!
    var to:String!
    var body:String!
    var contentType:String! // 聊天类型，0 text 1 image
    var time:String!
    var icon:String!
    var zType:String! //z_type : 正常消息(0)，打招呼(1), 快速回复(2);
    var nickName:String!
    var toIcon:String! // 用于聊天列表的好友用户头像展示
    
   
}
