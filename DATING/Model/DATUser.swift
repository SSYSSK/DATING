//
//  DATUser.swift
//  DATING
//
//  Created by 天星 on 17/4/6.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
import ObjectMapper


let kUser                 = "user"
let kBirtyday             = "birthday"
let kToken                = "token"
let kAcc_lng_distance     = "acc_lng_distance"
let kAcc_sex_bef_marriage = "acc_sex_bef_marriage"
let kAge                  = "age"
let kAlbums               = "albums"
let kApartment               = "apartment"
let kCity               = "city"
let kCoin_qty               = "coin_qty"
let kDating_advantage               = "dating_advantage"
var kDating_target = "dating_target"
var kDevice_id = "device_id"
var kDiploma = "diploma"
var kDisable_endtime = "disable_endtime"
var kDisable_starttime = "disable_starttime"
var kFast_chats = "fast_chats"
var kGender = "gender"
var kHeight = "height"
var kWeight = "weight"

var kHobby = "hobby"
var kIs_chat = "is_chat"
var kIs_register = "is_register"
var kIs_reminder_pay = "is_reminder_pay"
var kIs_see_qq = "is_see_qq"
var kLogin_name = "login_name"
var kLoginAgain_name = "loginAgain_name"
var kLogin_plain_pwd = "login_plain_pwd"
var kLoginAgain_Paaaword = "loginAgain_Paaaword"
var kMain_pict = "main_pict"
var kMain_pict_name = "name"
var kMain_pict_url = "url"
var kMain_pict_url_folder = "url_folder"
var kMain_pict_url_url_thum = "url_thum"

var kMarriage = "marriage"

var kMarriage_attitude = "marriage_attitude"

var kNickname = "nickname"

var kOpenfire_plain_pwd = "openfire_plain_pwd"
var kPersonality = "personality" // 性格特征
var kProvince = "province"
var kPsw_eft_time = "psw_eft_time"
var kqq_no = "qq_no"
var kwx_no = "weixin_no"
var kReplies = "replies"

var kSalary_fm = "salary_fm" // 收入范围开头
var kSalary_to = "salary_to" // 收入范围结尾
var kStatus = "status"
var kToken_code = "token_code"

var kToken_eftv_time = "token_eftv_time"
var kUrl = "url"
var kUser_id = "user_id"
var kVehicle = "vehicle" // 是否有车


var kEducation = "education"

var kDating_attitude = "dating_attitude" //爱情观
var kMating_attitude = "marriage_attitude" //爱情观

var kPhone = "tele_no"
var kHeart_words = "heart_words"

var kDatingTime = "datingTime"

let kMoney = "coin_qty"

var kis_rcv_audio = "is_rcv_audio"

let kis_rcv_video = "is_rcv_video"
let konline = "online"
class DATUser: BaseModel {
    
    var birtyday: String?
    var token : String?
    var acc_lng_distance:String? // 能否接受异地恋
    var acc_sex_bef_marriage:String? //能够接受婚前性行为
    var age:Int!
    var userAlbums = [DATUserAlbums]()
    var apartment:String? // 住房情况
    var city:String?
//    var coin_qty:Int? //金币数量
    var dating_advantage:String? //恋爱专长
    var dating_target:String? //交友目的
    var device_id:Int?
    var diploma:String? //学历
    var disable_endtime:String? //控制用户使用的实效时间（比如用户到期是2017-05-30），比如超过2017-05-30，比如用户只能读，不能改，不能聊天，不能上传图片
    var disable_starttime:String? //控制用户使用的实效时间（比如用户到期是2017-05-01），比如超过2017-05-30，比如用户只能读，不能改，不能聊天，不能上传图片
    var fast_chats = [String]() //快速，打招呼数组，你在前端，随机取一个
    
    
    var sex: Int?
    
    var height : Int?
    var like : String? //爱好
    var is_chat : Int? //是否可以聊天，整个项目是通过这个字段来控制是否可以聊
    var is_register : Int? //是否注册，系统没有用到，你要把解析出来吧
    var is_reminder_pay : Int? //  是否提示付费，如果是，需要在客户端提示用户付费（现在没有用到），你也把他解析出来
    var is_see_qq : Int? // 是否可以看QQ，微信代码，电话号码，
    var login_name : String?
    var login_plain_pwd : String?
    
    var main_picts_name : String?
    var main_picts_url : String?
    var main_picts_url_folder : String?
    var main_picts_url_thum : String?
    
    var marriage : String? //已婚/未婚
    var marriage_attitude : String? //婚姻观
    
    var dating_attitude : String? ////爱情观
    
    var nickname : String?
    var openfire_plain_pwd : String?
    var personality : String? //性格
    var province : String?

    var psw_eft_time : String? //秘密有效时间
    var qq_no : String?
    var replies = [String]() //回复数组值，你在客户端随机取一个
    var salary_fm : Int? //月收入范围，薪水范围开始值
    var salary_to : Int? // 月收入范围，薪水范围结束值，
    var status : Int?
    var token_code : String?
    var token_eftv_time : String? //对应token的有效时间，暂时没有控制，你要把他解析出来
    var url : String?
    var user_id : Int?
    var vehicle : String? //车辆
    var heart_words : String? //独白
    var wight:Int? //体重
    var wx_no : String? // 微信
    var phone:String? // 电话

    var money:Int! = 0
    
    var is_rcv_video:Bool = false
    var is_rcv_audio:Bool = false
    var online:Bool = false
    
    var sexStr:String {
        get{
            if sex == 0 {
                return "男"
            }else {
                return "女"
            }
        }
    }
    
    
    
    override init() {
        super.init()
        if let dict = FileOP.unarchive(kUserFileName) {
            self.update(validNSDictionary(dict))
        }
    }
    
    required init?(_ userDict: NSDictionary) {
        super.init()
        self.update(userDict)        
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }


    
    func getUserDetail(userTmp:DATUser) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_allinfo_get_by_login_name"
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        
        var user:[String:Any] = [String:Any]()
        user["login_name"] = validString(userTmp.login_name)
        
        param["device"] = device
        param["user"] = user
        print("userTmp.login_name===\(userTmp.login_name)")
        print("userTmp.token_code===\(userTmp.token_code)")
        token["login_name"] = userTmp.login_name
        token["token_code"] = userTmp.token_code
        biz.getUserDetail(param: param, operation: operation, token: token) { (data, error) in
            if error == nil{
                let userDict = validNSDictionary(data)
                self.update(validNSDictionary(userDict[kUser]))
                self.delegate?.refreshUI(self)
            } else {
                SSTProgressHUD.showErrorWithStatus(validString(error))
            }
        }
    }

    func getMyUserDetail(userTmp:DATUser) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
  
        operation["module"] = "user"
        operation["action"] = "user_allinfo_get_by_teleno"
        

        var user:[String:Any] = [String:Any]()
        user["tele_no"] = validString(userTmp.phone)

        param["user"] = user

        biz.getUserDetail(param: param, operation: operation) { (data, error) in
            if error == nil{
                let userDict = validNSDictionary(data)
                self.update(validNSDictionary(userDict[kUser]))
                
//                self = JSONDeserializer<DATUser>.deserializeFrom(json: userDict){
//                    print("\(self.nickname)  \(self.marriage_attitude) \(self.is_rcv_video) \(self.is_rcv_audio)")
//                    
//                }
                
                biz.user = self
                self.delegate?.refreshUI(self)
            } else {
                SSTProgressHUD.showErrorWithStatus(validString(error))
            }
        }
    }

    
    
    func updateUserBase(userTmp:DATUser) {
        
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_update_base"
        
        let device:[String:Any] = [
            "device_no": kDevice_no
        ]
        var user:[String:Any] = [String:Any]()
        user["age"] = userTmp.age
        user["apartment"] = userTmp.apartment
        user["birthday"] = userTmp.birtyday
        user["city"] = userTmp.city
        user["diploma"] = userTmp.diploma
        user["gender"] = userTmp.sex
        user["heart_words"] = userTmp.heart_words
        user["height"] = userTmp.height
        user["hobby"] = userTmp.like
        user["marriage"] = userTmp.marriage
        user["nickname"] = userTmp.nickname
        user["personality"] = userTmp.personality
        user["province"] = userTmp.province
        
        user["qq_no"] = userTmp.qq_no
        user["tele_no"] = userTmp.phone
        user["user_id"] = userTmp.user_id
        user["vehicle"] = userTmp.vehicle
        user["weight"] = userTmp.wight
        user["weixin_no"] = userTmp.wx_no
        user["province"] = userTmp.province
        user["salary_fm"] = userTmp.salary_fm
        user["salary_to"] = userTmp.salary_to
        user["nickname"] = userTmp.nickname
        
        param["device"] = device
        param["user"] = user
        
        token["login_name"] = biz.user?.login_name
        token["token_code"] = biz.user?.token_code
        
        biz.updateUserBase(param: param, operation: operation, token: token) { (data, error) in
           
            let userDict = validNSDictionary(data)
            self.update(validNSDictionary(userDict[kUser]))
            biz.user = self
            FileOP.archive(kUserFileName, object: validNSDictionary(data))

            self.delegate?.refreshUI(self)
        }
    }

    func updateUserLovePrf(userTmp:DATUser) {
        
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        var token:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_update_love_prf"
        
        let device:[String:Any] = [
            "device_no": kDevice_no
        ]
        var user:[String:Any] = [String:Any]()
        user["acc_lng_distance"] = userTmp.acc_lng_distance
        user["acc_sex_bef_marriage"] = userTmp.acc_sex_bef_marriage
        user["dating_advantage"] = userTmp.dating_advantage
        user["dating_attitude"] = userTmp.dating_attitude
        user["dating_target"] = userTmp.dating_target
        user["marriage_attitude"] = userTmp.marriage_attitude
        user["user_id"] = userTmp.user_id
      
        
        param["device"] = device
        param["user"] = user
        
        token["login_name"] = biz.user?.login_name

        biz.updateUserLovePrf(param: param, operation: operation, token: token) { (data, error) in
            
            let userDict = validNSDictionary(data)
            self.update(validNSDictionary(userDict[kUser]))
            biz.user = self
            FileOP.archive(kUserFileName, object: validNSDictionary(data))

            self.delegate?.refreshUI(self)
        }
    }
    
    func changePassword(oldPassword:String, newPassword:String, _ callback:@escaping RequestCallBack) {
        
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_chgpwd"

        var device:[String:Any] = [String:Any]()
        device["device_no"] = kDevice_no
        param["device"] = device
        
        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        user["login_encrypted_pwd"] = oldPassword
        user["login_new_encrypted_pwd"] = newPassword
        user["login_new_plain_pwd"] = newPassword
        param["user"] = user
        
        var token:[String:Any] = [String:Any]()
        token["login_name"] = biz.user?.login_name
        token["token_code"] = biz.user?.token_code
        param["token"] = token
        biz.changePassword(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
    }
    
    func forgetPassword(newPassword:String,code:String, _ callback:@escaping RequestCallBack){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "sms"
        operation["action"] = "tele_no_ency_pwd_chg"
        
        
        var sms:[String:Any] = [String:Any]()
        sms["tele_no"] = biz.user?.phone
        
        sms["login_encrypted_pwd_new"] = newPassword
        
        
        
        param["sms"] = sms
        
        
        biz.forgetPassword(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }

    }
    
    func update(_ userDict: NSDictionary) {
        

        self.birtyday = validString(userDict[kBirtyday])
        self.token = validString(userDict[kToken])
        self.acc_lng_distance = validString(userDict[kAcc_lng_distance])
        self.acc_sex_bef_marriage = validString(userDict[kAcc_sex_bef_marriage])
        self.age = validInt(userDict[kAge])
        let tuserAlbums = DATUserAlbums()
        self.userAlbums = tuserAlbums.setUserAlbums(array: validArray(userDict[kAlbums]))
        
        self.apartment = validString(userDict[kApartment])
        self.city = validString(userDict[kCity])
//        self.coin_qty = validInt(userDict[kCoin_qty])
        self.dating_advantage = validString(userDict[kDating_advantage])
        self.dating_target = validString(userDict[kDating_target])
        self.device_id = validInt(userDict[kDevice_id])
         self.diploma = validString(userDict[kDiploma])
        self.disable_endtime = validString(userDict[kDisable_endtime])
        self.disable_starttime = validString(userDict[kDisable_starttime])
        var tfast_chats = [String]()
        for fast_chat in validNSArray(userDict[kFast_chats]) {
            tfast_chats.append(validString(fast_chat))
        }
        fast_chats = tfast_chats
        self.sex = validInt(userDict[kGender])
        self.height = validInt(userDict[kHeight])
        self.wight = validInt(userDict[kWeight])
        
        self.like = validString(userDict[kHobby])
        self.is_chat = validInt(userDict[kIs_chat])
        self.is_register = validInt(userDict[kIs_register])
        self.is_reminder_pay = validInt(userDict[kIs_reminder_pay])
        self.is_see_qq = validInt(userDict[kIs_see_qq])
        self.login_name = validString(userDict[kLogin_name])
        self.login_plain_pwd = validString(userDict[kLogin_plain_pwd])

        let main_picts = validNSDictionary(userDict[kMain_pict])
        self.main_picts_name = validString(main_picts[kMain_pict_name])
        self.main_picts_url = validString(main_picts[kMain_pict_url])
        self.main_picts_url_folder = validString(main_picts[kMain_pict_url_folder])
        self.main_picts_url_thum = validString(main_picts[kMain_pict_url_url_thum])
        
        
        self.marriage = validString(userDict[kMarriage])
        self.marriage_attitude = validString(userDict[kMarriage_attitude])
        self.nickname = validString(userDict[kNickname])
        self.openfire_plain_pwd = validString(userDict[kOpenfire_plain_pwd])
        self.personality = validString(userDict[kPersonality])
        self.province = validString(userDict[kProvince])
        self.psw_eft_time = validString(userDict[kPsw_eft_time])
        self.qq_no = validString(userDict[kqq_no])
        self.wx_no = validString(userDict[kwx_no])
        self.heart_words = validString(userDict[kHeart_words])
        
        self.phone = validString(userDict[kPhone])
        self.vehicle = validString(userDict[kVehicle])
        self.personality = validString(userDict[kPersonality])//// 性格特征
        self.dating_attitude = validString(userDict[kDating_attitude])
        
        self.marriage_attitude = validString(userDict[kMating_attitude])
        

        self.money = validInt(userDict[kMoney])
        
        var treplies = [String]()
        for treplie in validNSArray(userDict[kReplies]) {
            treplies.append(validString(treplie))
        }
        self.replies = treplies
        
        self.salary_fm = validInt(userDict[kSalary_fm])
        self.salary_to = validInt(userDict[kSalary_to])
        self.status = validInt(userDict[kStatus])
        self.token_code = validString(userDict[kToken_code])
        
        self.token_eftv_time = validString(userDict[kToken_eftv_time])
        self.url = validString(userDict[kUrl])
        self.user_id = validInt(userDict[kUser_id])
        self.vehicle = validString(userDict[kVehicle])


        self.is_rcv_video = validBool(userDict[kis_rcv_video])
        self.is_rcv_audio = validBool(userDict[kis_rcv_audio])

        setUserDefautsData(kis_rcv_video, value: self.is_rcv_video)
        setUserDefautsData(kis_rcv_audio, value: self.is_rcv_audio)
        
        self.online = validBool(userDict[konline])
        
        self.delegate?.refreshUI(self)
    }
    
    func login(userName: String, password: String,  _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "sms"
        operation["action"] = "tele_no_login"
        
        

        var sms:[String:Any] = [String:Any]()
        sms["login_encrypted_pwd"] = password.MD5()
        sms["tele_no"] = userName
        param["sms"] = sms
        

        
        biz.login(param: param, operation: operation) { (data, error) in
            
            let userDict = validNSDictionary(data)
            
            self.update(validNSDictionary(userDict[kUser]))
            FileOP.archive(kUserFileName, object: validNSDictionary(data))

            print(validString(self.login_name))
            print(validString(self.openfire_plain_pwd))

            print(validString(self.token_code))
            
            setUserDefautsData(kToken_code, value: validString(self.token_code))
            setUserDefautsData(kLogin_name, value: validString(self.login_name))
            setUserDefautsData(kLoginAgain_name, value: userName)
            setUserDefautsData(kLoginAgain_Paaaword, value: password)
            setUserDefautsData(kOpenfire_plain_pwd, value: validString(self.openfire_plain_pwd))
            setUserDefautsData(kPhone, value: userName)
            NIMSDK.shared().loginManager.login(validString(self.login_name), token: validString(self.openfire_plain_pwd), completion: { (error) in
                print("error===\(error)")
                if error == nil {
                    print("登录陈工")
                }else {
                    print("登录失败==\(error)")
                }
            })
            callback(data, error)
            self.token_code = "2132222"
            
            biz.user = self
        }
    }
    
    
    // 获取验证码
    func getCode(phone: String,  _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "sms"
        operation["action"] = "tele_no_validcode_get"
        
        
        
        var sms:[String:Any] = [String:Any]()
        sms["device_id"] = validInt(kAlldevice_id)
        sms["tele_no"] = phone
        sms["valid_code"] = "000"

        param["sms"] = sms
        
        biz.getCode(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
    }
    
    // 验证手机号码是否被注册
    func phoneIsResit(phone: String,  _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "sms"
        operation["action"] = "tele_no_isrgstr"
        
        
        
        var sms:[String:Any] = [String:Any]()
        sms["tele_no"] = validString(phone)
       
        param["sms"] = sms
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = device_id
        param["device"] = device
        
//        var token:[String:Any] = [String:Any]()
//        token["login_name"] = biz.user?.user_id
//        token["token_code"] = biz.user?.token_code
        
        biz.isRegisPhone(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
    }
    
    //注册
    func registerEvent(user:DATUser, image:UIImage, code:String,   _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        
        // 上传图片
        biz.uploadImage(image: image, fileType: UploadImageType.icon.rawValue) { (data, error) in
            let userDict = validNSDictionary(data)
            let fileDict = validNSDictionary(userDict["file"])
            
            print("data===\(data)")
            print("error===\(error)")
            
            operation["module"] = "sms"
            operation["action"] = "tele_no_register"
            
            
            var param:[String:Any] = [String:Any]()
            
            var usertmp:[String:Any] = [String:Any]()
            usertmp["nickname"] = validString(user.nickname)
            usertmp["birthday"] = validString(user.birtyday)
            usertmp["sex"] = user.sex
            usertmp["url_thum"] = validString(fileDict["url"])
            param["user"] = usertmp
            
            var sms:[String:Any] = [String:Any]()
            sms["login_encrypted_pwd"] = user.login_plain_pwd?.MD5()
            sms["tele_no"] = user.phone
            sms["valid_code"] = code
            param["sms"] = sms
            
            print("user.login_plain_pwd===\(user.login_plain_pwd)")
            
            var device:[String:Any] = [String:Any]()
            device["device_no"] = "test_24"
            param["device"] = device
            
            biz.register(param: param, operation: operation) { (data, error) in
                callback(data, error)
            }

        }
    }

    //修改密码
    func forgetPasswordEvent(phone: String, password: String, code: String,  _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "sms"
        operation["action"] = "tele_no_pwd_forget"
        
        var sms:[String:Any] = [String:Any]()
        sms["login_encrypted_pwd"] = password.MD5()
        sms["tele_no"] = phone
        sms["valid_code"] = code
        
        print("password = = \(sms["login_encrypted_pwd"])")
        
        param["sms"] = sms
        
        biz.getCode(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
    }

    func uploadImage(image: UIImage, fileType:String, _ callback:@escaping RequestCallBack) {
        biz.uploadImage(image: image, fileType: fileType) { (data, error) in
             callback(data,error)
        }
    }
    
    func consumeForSendGift(price :Int ,_ callback:@escaping RequestCallBack){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "consume"
        operation["action"] = "consume_coin"
        
        var consume:[String:Any] = [String:Any]()
        
        consume["csm_coin_qty"] = price
        consume["login_name"] = biz.user?.login_name
        
        param["consume"] = consume
        
        biz.consume(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
        
    }
    
    func consumeForSendAppointment(price:Int,_ callback:@escaping RequestCallBack){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "consume"
        operation["action"] = "consume_coin"
        
        var consume:[String:Any] = [String:Any]()
        
        consume["csm_coin_qty"] = price
        consume["login_name"] = biz.user?.login_name
        
        param["consume"] = consume
        
        biz.consume(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
    }
    
    func consume( type:TType, time:Int32,  _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "consume"
        operation["action"] = "consume_coin"
        
        var consume:[String:Any] = [String:Any]()
        var money = 0
        switch type.rawValue {
        case 0:
            print("视频聊天扣费")
            print("type.rawValue==\(type.rawValue)")
            if biz.user?.sex == 0 { // 男
                if time == 1 {
                     money = validInt(biz.config?.male_video_price) * 1
                    print("视频聊天扣费11111111")
                }else {
                    money = validInt(biz.config?.male_video_price) * mini
                }
                
            }else {  //女
                if time == 1 {
                    money = validInt(biz.config?.female_video_price) * 1
                    print("视频聊天扣费11111111")
                }else {
                    money = validInt(biz.config?.female_video_price) * mini
                }
            }
        case 1:
            print("语音聊天扣费")
            print("type.rawValue==\(type.rawValue)")
            if biz.user?.sex == 0 { // 男
                if time == 1 {
                    money = validInt(biz.config?.male_audio_price) * 1
                    
                    print("视频聊天扣费11111111")
                }else {
                    money = validInt(biz.config?.male_audio_price) * mini
                }
            }else {  //女
                if time == 1 {
                     money = validInt(biz.config?.female_audio_price) * 1
                    print("视频聊天扣费11111111")
                }else {
                     money = validInt(biz.config?.female_audio_price) * mini
                }
               
            }
        default:
            print("--")
        }
        
        
        consume["csm_coin_qty"] = money
        consume["login_name"] = biz.user?.login_name
        
        param["consume"] = consume
        
        biz.consume(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }

    }
    
    func addFriend(user:DATUser, _ callback:@escaping RequestCallBack){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_friend_add"
        
        var friend:[String:Any] = [String:Any]()
        
        friend["login_name_fm"] = biz.user?.login_name
        friend["login_name_to"] = user.login_name
        
        param["friend"] = friend
        
        biz.addFriend(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }

    }
    
    func deleteFriend(user:DATUser, _ callback:@escaping RequestCallBack){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_friend_del"
        
        var friend:[String:Any] = [String:Any]()
        
        friend["login_name_fm"] = biz.user?.login_name
        friend["login_name_to"] = user.login_name
        
        param["friend"] = friend
        
        biz.deleteFriend(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
        
    }
    
    func addBalck(user:DATUser, _ callback:@escaping RequestCallBack){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_blacklist_add"
        
        var friend:[String:Any] = [String:Any]()
        
        friend["login_name_fm"] = biz.user?.login_name
        friend["login_name_to"] = user.login_name
        
        param["friend"] = friend
        
        biz.addBalck(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
        

    }
    func deleteBalck(user:DATUser, _ callback:@escaping RequestCallBack){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_blacklist_del"
        
        var friend:[String:Any] = [String:Any]()
        
        friend["login_name_fm"] = biz.user?.login_name
        friend["login_name_to"] = user.login_name
        
        param["friend"] = friend
        
        biz.deleteBalck(param: param, operation: operation) { (data, error) in
            callback(data, error)
        }
    }
    
    func restion(user:DATUser,content:String, subject: String,  _ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "complain"
        operation["action"] = "complain_addnew"
        
        
        
        var complain:[String:Any] = [String:Any]()
        complain["login_name_fm"] = biz.user?.login_name
        complain["login_name_to"] = user.login_name
        complain["content"] = validString(content)
        complain["subject"] = validString(subject)
        param["complain"] = complain
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        biz.restion(param: param, operation: operation, token: token) { (data, error) in
            callback(data, error)
        }
    }
    
    func videoDisturb(is_rcv_video:Bool,_ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_video_disturb"
        

        var device:[String:Any] = [String:Any]()
        device["device_no"] = validString(biz.user?.device_id)
        param["device"] = device
        
        var user:[String:Any] = [String:Any]()
        user["is_rcv_video"] = is_rcv_video
        user["login_name"] = biz.user?.login_name
        param["user"] = user

        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        biz.restion(param: param, operation: operation, token: token) { (data, error) in
            callback(data, error)
        }
    }

    func audioDisturb(is_rcv_video:Bool,_ callback:@escaping RequestCallBack) {
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_audio_disturb"
        
        
        var device:[String:Any] = [String:Any]()
        device["device_no"] = biz.user?.device_id
        param["device"] = device
        
        var user:[String:Any] = [String:Any]()
        user["is_rcv_video"] = is_rcv_video
        user["login_name"] = biz.user?.login_name
        param["user"] = user
        
        
        var token:[String:Any] = [String:Any]()
        token["token_code"] = biz.user?.token_code
        token["login_name"] = biz.user?.login_name
        
        
        biz.restion(param: param, operation: operation, token: token) { (data, error) in
            callback(data, error)
        }
    }

}

