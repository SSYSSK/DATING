//
//  DATProposalData.swift
//  DATING
//
//  Created by 天星 on 17/5/4.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATProposalData: BaseModel {
    func feedbackAddnew(text:String, phone:String, _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "feedback"
        operation["action"] = "feedback_addnew"
        
        let device:[String:Any] = [
            "device_no": kDevice_no
        ]
        var feedback:[String:Any] = [String:Any]()
        feedback["contact_way"] = phone
        feedback["content"] = text
        feedback["login_name"] = biz.user?.login_name
        feedback["subject"] = "功能建议"

        param["device"] = device
        param["feedback"] = feedback
        
        token["login_name"] = biz.user?.login_name
      
        biz.feedbackAddnew(param: param, operation: operation, token: token) { (data, error) in
           
            callback(data, error)
        }

    }
}
