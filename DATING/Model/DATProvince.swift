//
//  DATProvince.swift
//  DATING
//
//  Created by 天星 on 17/7/3.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATProvince: BaseModel {
    var name:String!
    var citys:[DATCity]!
    
    func setDict(dict: NSDictionary) -> DATProvince{
    
        let province = DATProvince()
        province.name = validString(dict["Name"])
  
        let citys = DATCity().setData(dict: dict)
        province.citys = citys
        return province
    }
    
    
}
