//
//  DATCity.swift
//  DATING
//
//  Created by 天星 on 17/7/3.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATCity: BaseModel {
    var name:String!
    
    func setData(dict:NSDictionary) -> [DATCity] {
        print(dict)
        var citys = [DATCity]()
        for dictTmp in validNSArray(dict["Citys"]) {
            let city = DATCity()
            city.name = validString(validNSDictionary(dictTmp)["Name"])
            citys.append(city)
        }
        return citys
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
   
}
