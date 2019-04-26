//
//  DATAppointment.swift
//  DATING
//
//  Created by 天星 on 17/5/24.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kAppointmentTitle         = "subject"
let kAppointmentSex           = "dating_gender"
let kAppointmentAppplySum     = "apply_num"
let kAppointmentProvince      = "province"
let kAppointmentLogin_name    = "login_name"
let kAppointmentUser_id    = "user_id"
let kAppointmentDating_time   = "dating_time"
let kAppointmentType          = "type"
let kAppointmentAddress       = "address"
let kAppointmentRecSeq        = "rec_seq"
let kAppointmentDatingId      = "dating_id"
let kAppointmentCity          = "city"
let kAppointmentUpNum         = "up_num"
let kAppointmentUser          = "user"
let kAppointmentPayment       = "payment"
let kAppointmentStatus        = "status"
let kAppointmentccomments     = "comments"
let kAppointmentCreatedtime   = "created_time"
let kAppointmentDatingApplys  = "dating_applys"
let kAppointmentEffect_days  = "effect_days"

let kAppointment        = "dating"
class DATAppointment: DATUser {
    var effect_days:Int?
    var title:String?
    var psex:Int?  // 1 女  0 男
    var applyNum:Int? //申请约会的数量
    var pprovince:String?
    var loginName:String?
    var userId:String?
    var datingTime:String? //约会有效期
    var type:Int? // -1 所有 0 非会员 1 会员
    var address:String?
    var recSeq:Int? // 这个是记录循序，控制翻页的
    var datingId:Int?
    var pcity:String?
    var upNum:Int? //点赞的数量
    var payment:String?
    var pstatus:Int?
    var comments:String?
    var createdTime:String?
    var time:String?
    var applys:[DatingApply]?
    
    func updateApp(_ appointmentDict: NSDictionary) {
        super.update(validNSDictionary(appointmentDict[kUser]))
        self.title = validString(appointmentDict[kAppointmentTitle])
        self.sex = validInt(appointmentDict[kAppointmentSex])
        self.applyNum = validInt(appointmentDict[kAppointmentAppplySum])
        self.province = validString(appointmentDict[kAppointmentProvince])
        self.loginName = validString(appointmentDict[kAppointmentLogin_name])
        self.datingTime = validString(appointmentDict[kAppointmentDating_time])
        self.type = validInt(appointmentDict[kAppointmentType])
        
        
        self.recSeq = validInt(appointmentDict[kAppointmentRecSeq])
        self.datingId = validInt(appointmentDict[kAppointmentDatingId])
        self.city = validString(appointmentDict[kAppointmentCity])
        
        
        self.address = validString(appointmentDict[kAppointmentAddress])
        
        
        self.upNum = validInt(appointmentDict[kAppointmentUpNum])
        
        self.payment = validString(appointmentDict[kAppointmentPayment])
        self.status = validInt(appointmentDict[kAppointmentStatus])
        self.comments = validString(appointmentDict[kAppointmentccomments])
        self.createdTime = validString(appointmentDict[kAppointmentCreatedtime])
        self.psex = validInt(appointmentDict[kAppointmentSex])
        self.userId = validString(appointmentDict[kAppointmentUser_id])
        self.effect_days = validInt(appointmentDict[kAppointmentEffect_days])
        var userTmp = [DatingApply]()
        for userDict in validNSArray(appointmentDict[kAppointmentDatingApplys]) {
            let apply = DatingApply(validNSDictionary(userDict))
            userTmp.append(apply!)
        }
        self.applys = userTmp
        
        self.delegate?.refreshUI(self)
    }

    func datingUp(dating_id:Int, _ callback:@escaping RequestCallBack) {
        
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "dating"
        operation["action"] = "dating_up_save"
        
    
        var dating:[String:Any] = [String:Any]()
        dating["dating_id"] = dating_id
        dating["login_name"] = validString(biz.user?.login_name)
        
        let device:[String:Any] = [
            "device_no": kDevice_no
        ]
        param["dating_up"] = dating
        param["device"] = device

        
        token["login_name"] = biz.user?.login_name
        token["token_code"] = biz.user?.token_code
        
        biz.datingUp(param: param, operation: operation, token: token) { (data, error) in
            callback(data, error)
        }
    }

    func datingApply(dating_id:Int, _ callback:@escaping RequestCallBack) {
        
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "dating"
        operation["action"] = "dating_apply_save"
        
        
        var datingApply:[String:Any] = [String:Any]()
        datingApply["dating_id"] = dating_id
        datingApply["login_name"] = validString(biz.user?.login_name)
        datingApply["apply_time"] = Date().format()
        datingApply["comments"] = "comments"
        
        let device:[String:Any] = [
            "device_no": kDevice_no
        ]
        param["dating_apply"] = datingApply
        param["device"] = device
        
        
        token["login_name"] = biz.user?.login_name
        token["token_code"] = biz.user?.token_code
        
        biz.datingApply(param: param, operation: operation, token: token) { (data, error) in
             callback(data, error)
        }
    }

    func getDetail(dating_id:Int, login_name:String) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "dating"
        operation["action"] = "dating_get_by_dating_id"
        
        
        var dating:[String:Any] = [String:Any]()
        dating["dating_id"] = dating_id
        dating["login_name"] = login_name

        let device:[String:Any] = [
            "device_no": kDevice_no
        ]
        param["dating"] = dating
        param["device"] = device
        
        
        token["login_name"] = login_name

        token["token_code"] = biz.user?.token_code
        
        biz.getDatingDetail(param: param, operation: operation, token: token) { (data, error) in
            let appDict = validNSDictionary(data)
            self.updateApp(validNSDictionary(appDict[kAppointment]))
            
            self.delegate?.refreshUI(self)
        }
    }
    
    func deleteAppointment(dating_id:Int, _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        
        operation["module"] = "dating"
        operation["action"] = "dating_delete"
        
        
        var param:[String:Any] = [String:Any]()
        
        
        var dating:[String:Any] = [String:Any]()
        dating["dating_id"] = validInt(dating_id)
        
        param["dating"] = dating
        
        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        param["user"] = user
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var token:[String:Any] = [String:Any]()
        token["login_name"] = biz.user?.login_name
        token["token_code"] = biz.user?.token_code
        
        
        biz.sendAppointment(param: param, operation: operation, token: token) { (data, error) in
            callback(data, error)
        }
        
    }

    
    func getTitles(_ callback:@escaping RequestCallBack){
    //{"operation":{"module":"config","action":"enum_get"}}
        var operation:[String:Any] = [String:Any]()
        let param:[String:Any] = [String:Any]()
        
        operation["module"] = "config"
        operation["action"] = "enum_get"
        
        biz.getTitles(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
    }
}
