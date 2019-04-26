//
//  DATServiceInfo.swift
//  DATING
//
//  Created by 林丽萍 on 2017/4/6.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATServiceInfo: BaseModel {
    var deviceId:Int! = 0
    func uploadAppInfo(_ callback:@escaping RequestCallBack) {
        biz.uploadAppInfo { (data, error) in
            callback(data, error)
            
        }
    }
}
