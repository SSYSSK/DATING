////
////  BizRequestCenter.swift
////  sst-ios
////
////  Created by Liang Zhang on 16/4/12.
////  Copyright © 2016年 lzhang. All rights reserved.
////
//
//import UIKit
//
enum appointmentSearch {
    case all
    case my
    case key
}
open class BizRequestCenter {
//
    let ntwkAccess = NetworkAccess()
//
    var homeData: DATHomeData?
    var user: DATUser?
    var config: DATConfig?
    var cheatData: DATCheatData?
    var giftData: DATGiftData?
    var city:String?
    var province:String?
//    init() {
//        ntwkAccess.listen()
//        
//        if let data = FileOP.unarchive(kUserFileName) {
//            if let tmpUser = SSTUser(JSON: validDictionary(data)) {
//                self.user = tmpUser
//            }
//        } else {
//            self.user = SSTUser()
//        }
//        
//        if let data = FileOP.unarchive(kCartFileName) {
//            if let tmpCart = SSTCart(JSON: validDictionary(data)) {
//                self.cart = tmpCart
//            }
//        } else {
//            self.cart = SSTCart()
//        }
//        
//    }
//    
//    class var sharedInstance : BizRequestCenter {
//        return biz
//    }
//
//
//    
//    /**
//     1.获取服务器信息
//     
//     - parameter callback: 返回结果
//     */
    open func uploadAppInfo(_ callback:@escaping RequestCallBack){
        var param:[String:Any] = [String:Any]()
        
        var operation:[String:Any] = [String:Any]()
        
        operation["module"] = "report"
        operation["action"] = "report_info_auto"
        
        let device:[String:Any] = [
            "os_name":"ios",
            "os_version_name": kAppBuild,
            "os_version_code": "0",
            "cpu": "ARMv7 Processor rev 1 (v7l)",
            "memory": "1.66 GB",
            "brand": "iphone7",
            "model": "SM-G9008V",
            "load_session_id": "4ad43a89-12be-4eeb-8fa0-861e74635294",
            "load_on_off": "off",
            "load_ip": "192.168.0.140",
            "service_provider": "CMCC",
            "tele_code": "off",
            "device_no": kDevice_no
        ]
        
        let appinfo:[String:Any] = [
            "app_identifier":"com.zzr.easylove",
            "app_name": "约会吧",
            "app_version_code": 40,
            "app_version_name": "2.2.0",
            "memchannelory": "wdj",
            "has_paysdk": true
        ]
        param["device"] = device
        param["appinfo"] = appinfo
      
        ntwkAccess.request(.post, url: kBaseURLString, param: param, pager: nil, operation: operation) { (data, error) in
                callback(data,error)
        }
    }
    
    //2、获取配置信息
    open func getConfig(_ callback:@escaping RequestCallBack){
        var param:[String:Any] = [String:Any]()
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "config"
        operation["action"] = "config_get"
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        ntwkAccess.request(.post, url: kBaseURLString, param: param , pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    //3、获取用户信息
    open func getUser(_ callback:@escaping RequestCallBack){
        
        var param:[String:Any] = [String:Any]()
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "user"
        operation["action"] = "user_allinfo_get_by_dvcno"
       
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    //4、获取首页信息（分页）
    open func getbeginHomePage(rec_seq: Int = 0, rows_per_page: Int = 12, ageFrom:Int = -1, ageTo:Int = -1, heightFrom:Int = -1, heightTo:Int = -1, salary_rangeFrom:Int = -1, salary_rangeTo:Int = -1 , distance_rangeFrom:Int = 0, distance_rangeTo:Int = -1, province:String = "不限", city:String = "不限", _ callback:@escaping RequestCallBack){
        
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "user"
        operation["action"] = "user_main_data"
        
        
        var pager:[String:Any] = [String:Any]()
        pager["cur_pageno_in"] = 0
        pager["rec_move"] = "backward"
        pager["rec_seq"] = rec_seq
        pager["rows_per_page"] = rows_per_page
        
        
        var param:[String:Any] = [String:Any]()
        var user:[String:Any] = [String:Any]()
        user["user_id"] = biz.user?.user_id
        param["user"] = user
        
        var search:[String:Any] = [String:Any]()
        var age_range:[String:Any] = [String:Any]()
        age_range["from"] = ageFrom
        age_range["to"] = ageTo
        search["age_range"] = age_range
        
        var height_range:[String:Any] = [String:Any]()
        height_range["from"] = heightFrom
        height_range["to"] = heightTo
        search["height_range"] = height_range
        
        var salary_range:[String:Any] = [String:Any]()
        salary_range["from"] = salary_rangeFrom
        salary_range["to"] = salary_rangeTo
        search["salary_range"] = salary_range
        
        var distance_range:[String:Any] = [String:Any]()
        distance_range["from"] = distance_rangeFrom
        distance_range["to"] = distance_rangeTo
        search["distance_range"] = distance_range
        
        var location:[String:Any] = [String:Any]()
        location["province"] = "不限"
        
        location["city"] = "不限"
        
        search["location"] = location
        
        param["search"] = search
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param ,pager: pager,operation: operation,token: token) { (data, error) in
            callback(data,error)
        }
    }
    //4、获取首页信息（分页）
    open func getHomePage(rec_seq: Int = 0, rows_per_page: Int = 12, ageFrom:Int = -1, ageTo:Int = -1, heightFrom:Int = -1, heightTo:Int = -1, salary_rangeFrom:Int = -1, salary_rangeTo:Int = -1 , distance_rangeFrom:Int = 0, distance_rangeTo:Int = -1, province:String = "不限", city:String = "不限", _ callback:@escaping RequestCallBack){
        
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "user"
        operation["action"] = "user_main_data"
        
        
        var pager:[String:Any] = [String:Any]()
        pager["cur_pageno_in"] = 0
        pager["rec_move"] = "backward"
        pager["rec_seq"] = rec_seq
        pager["rows_per_page"] = rows_per_page
        
        
        var param:[String:Any] = [String:Any]()
        var user:[String:Any] = [String:Any]()
        user["user_id"] = biz.user?.user_id
        param["user"] = user
        
        var search:[String:Any] = [String:Any]()
        var age_range:[String:Any] = [String:Any]()
        age_range["from"] = ageFrom
        age_range["to"] = ageTo
        search["age_range"] = age_range
        
        var height_range:[String:Any] = [String:Any]()
        height_range["from"] = heightFrom
        height_range["to"] = heightTo
        search["height_range"] = height_range
        
        var salary_range:[String:Any] = [String:Any]()
        salary_range["from"] = salary_rangeFrom
        salary_range["to"] = salary_rangeTo
        search["salary_range"] = salary_range
        
        var distance_range:[String:Any] = [String:Any]()
        distance_range["from"] = distance_rangeFrom
        distance_range["to"] = distance_rangeTo
        search["distance_range"] = distance_range
        
        var location:[String:Any] = [String:Any]()
        let arr1:Array = validArray(biz.province?.components(separatedBy: "省"))
        if arr1.count > 0 {
            location["province"] = validString(arr1[0])
        }else{
            location["province"] = "不限"
        }
        
        let cityArr:Array = validArray(biz.city?.components(separatedBy: "市"))
        if cityArr.count > 0 {
            location["city"] = validString(cityArr[0])
        }else{
            location["city"] = "不限"
        }
        
        search["location"] = location
        
        param["search"] = search
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param ,pager: pager,operation: operation,token: token) { (data, error) in
            callback(data,error)
        }
    }
    //4、获取首页信息 查找（分页）
//    "cur_pageno_in": 0,  ／／没用到
//    "rec_move": "forward", //forwar  -> 下一页
//    "rec_seq": 0, //  第几页
//    "rows_per_page": 12 // 每页多少条
    open func searchHomePage(rec_seq: Int = 0, rows_per_page: Int = 12, ageFrom:Int = -1, ageTo:Int = -1, heightFrom:Int = -1, heightTo:Int = -1, salary_rangeFrom:Int = -1, salary_rangeTo:Int = -1 , distance_rangeFrom:Int = 0, distance_rangeTo:Int = -1, province:String = "不限", city:String = "不限", _ callback:@escaping RequestCallBack){
       
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "user"
        operation["action"] = "user_search"
        

        var pager:[String:Any] = [String:Any]()
        pager["cur_pageno_in"] = 0
    
        pager["rec_seq"] = rec_seq
        pager["rows_per_page"] = rows_per_page
        
        
        var param:[String:Any] = [String:Any]()
        var user:[String:Any] = [String:Any]()
        user["user_id"] = biz.user?.user_id
        param["user"] = user
        
        var search:[String:Any] = [String:Any]()
        var age_range:[String:Any] = [String:Any]()
        age_range["from"] = ageFrom
        age_range["to"] = ageTo
        search["age_range"] = age_range

        var height_range:[String:Any] = [String:Any]()
        height_range["from"] = heightFrom
        height_range["to"] = heightTo
        search["height_range"] = height_range

        var salary_range:[String:Any] = [String:Any]()
        salary_range["from"] = salary_rangeFrom
        salary_range["to"] = salary_rangeTo
        search["salary_range"] = salary_range
        
        var distance_range:[String:Any] = [String:Any]()
        distance_range["from"] = distance_rangeFrom
        distance_range["to"] = distance_rangeTo
        search["distance_range"] = distance_range
        
        var location:[String:Any] = [String:Any]()
        let arr1:Array = validArray(biz.province?.components(separatedBy: "省"))
        if arr1.count > 0 {
            location["province"] = validString(arr1[0])
        }else{
            location["province"] = "不限"
        }
        
        let cityArr:Array = validArray(biz.city?.components(separatedBy: "市"))
        if cityArr.count > 0 {
            location["city"] = validString(cityArr[0])
        }else{
            location["city"] = "不限"
        }
        
        search["location"] = location
        
        param["search"] = search

        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param ,pager: pager,operation: operation,token: token) { (data, error) in
            callback(data,error)
        }
    }
    
    //3、保存用户信息
    open func updateUserBase(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param, pager: nil, operation: operation, token: token) { (data, error) in
             callback(data,error)
        }
    }

    //4、保存用户恋爱便好信息
    open func updateUserLovePrf(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param, pager: nil, operation: operation, token: token) { (data, error) in
            callback(data,error)
        }
    }

    
    //5 、建议
    open func feedbackAddnew(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param, pager: nil, operation: operation, token: token) { (data, error) in
            callback(data,error)
        }
    }
    
    //6、获取用户详情
    open func getUserDetail(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param, pager: nil, operation: operation, token: token) { (data, error) in
            callback(data,error)
        }
    }

    //7、上传图片
    open func uploadImage(image: UIImage, fileType:String, _ callback:@escaping RequestCallBack){
        print("image==\(image)")
        ntwkAccess.uploadFile(image: image,fileType: fileType) { (data, error) in
            callback(data,error)
        }
    }
    
    //8 、修改密码
    open func changePassword(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    //8 、忘记密码
    open func forgetPassword(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    
    
    //9.获取约会列表
    open func getAllAppointment(rec_move: String, rec_seq: Int = 0, rows_per_page: Int = 12,  _ callback:@escaping RequestCallBack){
        
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "dating"
        
        operation["action"] = "dating_get_all"
        
        var pager:[String:Any] = [String:Any]()
        pager["cur_pageno_in"] = 0
        pager["rec_move"] = rec_move
        pager["rec_seq"] = rec_seq
        pager["rows_per_page"] = rows_per_page
        
        
        var param:[String:Any] = [String:Any]()
        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        param["user"] = user
 

        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param ,pager: pager,operation: operation,token: token) { (data, error) in
            callback(data,error)
        }
    }
    
    //9.获取约会列表
    open func getMyAppointment(rec_move: String, rec_seq: Int = 0, rows_per_page: Int = 12, _ callback:@escaping RequestCallBack){
        
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "dating"
        
        operation["action"] = "dating_get_mine_by_login_name"
        
        var pager:[String:Any] = [String:Any]()
        pager["cur_pageno_in"] = 0
        pager["rec_move"] = rec_move
        pager["rec_seq"] = rec_seq
        pager["rows_per_page"] = rows_per_page
        
        
        var param:[String:Any] = [String:Any]()
        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        param["user"] = user
        
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param ,pager: pager,operation: operation,token: token) { (data, error) in
            callback(data,error)
        }
    }

    //9.获取约会列表
    open func searchAppointment(rec_move: String, rec_seq: Int = 0, rows_per_page: Int = 12, searchKey:String = "", sex:String = "1", province:String = "不限",city:String = "不限", _ callback:@escaping RequestCallBack){
        
        
        
        var operation:[String:Any] = [String:Any]()
        operation["module"] = "dating"
        
        operation["action"] = "dating_get_search"
        
        var pager:[String:Any] = [String:Any]()
        pager["cur_pageno_in"] = 0
        pager["rec_move"] = rec_move
        pager["rec_seq"] = rec_seq
        pager["rows_per_page"] = rows_per_page
        
        
        var param:[String:Any] = [String:Any]()
        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        param["user"] = user
        
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        
        var search:[String:Any] = [String:Any]()
        search["keyword"] = searchKey
        search["dating_gender"] = validInt(sex)

        var location:[String:Any] = [String:Any]()
        location["province"] = province
        location["city"] = city
        search["location"] = location
        param["search"] = search
        
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param ,pager: pager,operation: operation,token: token) { (data, error) in
            callback(data,error)
        }
    }

    
    //10 、赞
    open func datingUp(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    //11 、赴约
    open func datingApply(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    //12 、获取约会详情
    open func getDatingDetail(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 13 登录
    open func login(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    // 14 获取验证码
    open func getCode(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }

    // 15 注册
    open func register(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    //16 发布约会
    open func sendAppointment(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 获取微信支付信息
    open func getWXPrepay(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation, token: token) { (data, error) in
            callback(data,error)
        }
    }
    
    // 扣除金币
    
    open func consume(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 获取关注用户列表
    open func getFriendList(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 添加关注
    open func addFriend(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    // 删除关注
    open func deleteFriend(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 加黑名单
    open func addBalck(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    // 加黑名单
    open func deleteBalck(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    
    // 获取约会titles
    open func getTitles(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 获取礼物列表
    open func getGiftByUser(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 获取礼物选择列表
    open func getGiftList(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 举报
    open func restion(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }

    // 验证手机号码是否被注册
    open func isRegisPhone(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        print("param=\(param)")
        print("operation=\(operation)")

        print("token=\(token)")

        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    // 视频免打扰
    open func videoDisturb(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
      
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
    
    // 语音免打扰
    open func audioDisturb(param: [String:Any], operation: [String: Any]? = nil, token: [String: Any]? = nil, _ callback:@escaping RequestCallBack){
        
        ntwkAccess.request(.post, url: kBaseURLString, param: param,  pager: nil, operation: operation) { (data, error) in
            callback(data,error)
        }
    }
    
}
