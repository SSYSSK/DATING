//
//  DATWXOrder.swift
//  DATING
//
//  Created by 天星 on 17/7/7.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATWXOrder: BaseModel {
    
    func getWXPrepay(money:Int,message:String, _ callback:@escaping RequestCallBack) {
        
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "payment"
        operation["action"] = "wx_prepayid_get"
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var payment:[String:Any] = [String:Any]()
        payment["amount"] = money
        payment["body"] = message
        let num = arc4random_uniform(UInt32(1000))
       
        payment["out_trade_no"] = "\(validString(biz.user?.user_id))\(validString(num))"
        payment["prepay_id"] = ""
        param["payment"] = payment
       
        token["login_name"] = biz.user?.login_name
        token["token_code"] = biz.user?.token_code
        
       // param["token"] = token
        
        biz.getWXPrepay(param: param, operation: operation, token: token) { (data, error) in
            if error == nil{
               callback(data,error)
            } else {
                print(error)
                SSTProgressHUD.showErrorWithStatus(validString(error))
            }
        }

    }
}
