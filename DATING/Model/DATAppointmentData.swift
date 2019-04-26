//
//  DATAppointmentData.swift
//  DATING
//
//  Created by 天星 on 17/5/24.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kAppointmentsData = "datings"
class DATAppointmentData: BaseModel {
    var appointments = [DATAppointment]()
    override init() {
        super.init()
//        if let dict = FileOP.unarchive(kAppointmentFileName) {
//            self.update(validDictionary(dict))
//        }
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    func uploadUpdate(_ dict:  Dictionary<String,Any>) {
        let appointments = validArray(dict[kAppointmentsData])
        for appointmentDict in appointments {
            let appointment = DATAppointment()
            appointment.updateApp(validNSDictionary(appointmentDict))
            self.appointments.append(appointment)
        }
        print(self.appointments)
    }
    
    func update(_ dict:  Dictionary<String,Any>) {
        var appointmentsT = [DATAppointment]()
        let appointments = validArray(dict[kAppointmentsData])
        for appointmentDict in appointments {
            let appointment = DATAppointment()
            appointment.updateApp(validNSDictionary(appointmentDict))
            appointmentsT.append(appointment)
        }
        self.appointments = appointmentsT
        print(self.appointments)
        
    }
    
    func fetchData() {
        biz.getAllAppointment(rec_move: "backward", rec_seq: 0) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
//                FileOP.archive(kAppointmentFileName, object: validNSDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
    func getMyAppointment(){
        biz.getMyAppointment(rec_move: "backward", rec_seq: 0) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
//                FileOP.archive(kAppointmentFileName, object: validNSDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
    func searchAppointment(searchKey:String = "", sex:String = "1", province:String = "不限",city:String = "不限"){
        
        biz.searchAppointment(rec_move: "backward", rec_seq: 0, searchKey: searchKey, sex: sex, province: province, city: city) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
//                FileOP.archive(kAppointmentFileName, object: validNSDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
    func sendAppointment(appointment: DATAppointment, _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        
        operation["module"] = "dating"
        operation["action"] = "dating_addnew"
        
        
        var param:[String:Any] = [String:Any]()
 
        
        var dating:[String:Any] = [String:Any]()
        dating["dating_time"] = appointment.datingTime
        dating["subject"] = appointment.title
        dating["province"] = appointment.pprovince
        dating["city"] = appointment.pcity
        dating["address"] = appointment.address
        dating["payment"] = appointment.payment
        dating["content"] = appointment.comments
        dating["type"] = -1
        dating["dating_gender"] = appointment.psex
        dating["effect_days"] = validInt(appointment.datingTime)
        
        param["dating"] = dating
        
        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        param["user"] = user

        biz.sendAppointment(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }

    }
    
    func changeAppointment(appointment: DATAppointment, _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        
        operation["module"] = "dating"
        operation["action"] = "dating_base_update"
        
        
        var param:[String:Any] = [String:Any]()
        
        
        var dating:[String:Any] = [String:Any]()
        dating["dating_time"] = appointment.datingTime
        dating["subject"] = appointment.title
        dating["province"] = appointment.pprovince
        dating["city"] = appointment.pcity
        dating["address"] = appointment.address
        dating["payment"] = appointment.payment
        dating["content"] = appointment.comments
        dating["type"] = -1
        dating["dating_gender"] = appointment.psex
        dating["effect_days"] = validInt(appointment.datingTime)
        dating["dating_id"] = validInt(appointment.datingId)
        
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
    
        
    func uploadRefresh(rec_seq: Int) {
        print("rec_seq=====\(rec_seq)")
        biz.getAllAppointment(rec_move: "forward", rec_seq: rec_seq) { (data, error) in
            if error == nil && data != nil {
                self.uploadUpdate(validDictionary(data))
                FileOP.archive(kAppointmentFileName, object: validDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
}
