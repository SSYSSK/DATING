//
//  DATConfig.swift
//  DATING
//
//  Created by 林丽萍 on 2017/4/9.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

let kConfig = "config"

let kCan_chat_2_mem    = "can_chat_2_mem"
let kChat_usrs_4_female       = "chat_usrs_4_female"
let kChat_usrs_4_male       = "chat_usrs_4_male"
let kCur_srv_ip       = "cur_srv_ip"
let kFree_chnl_ver       = "free_chnl_ver"
let kGuess_coin_list       = "guess_coin_list"

let kOpenfire_domain       = "openfire_domain"
let kOpenfire_ip       = "openfire_ip"
let kOpenfire_port       = "openfire_port"

let kPrice_member_list       = "price_member_list"
let kPrice_vip_list       = "price_vip_list"
let kSlogan  = "slogan"

let kUrlpaths  = "urlpaths"
let kUrl_path_1  = "url_path_1"
let kUrl_path_2  = "url_path_2"
let kUrl_path_3  = "url_path_3"
let kUrl_path_aliyun  = "url_path_aliyun"


let kmale_video_price = "male_video_price" // 男性的视频价格
let kmale_audio_price = "male_audio_price" // 男性的语音价格

let kfemale_video_price = "female_video_price" //女性的视频价格
let kfemale_audio_price = "female_audio_price" //女性的语音价格
let kdating_apply_price = "dating_apply_price" //女性的语音价格

let kis_dial_audio = "is_dial_audio" // 系统是否允许语音
let kis_dial_video = "is_dial_video" // 系统是否允许视频
class DATConfig: BaseModel {
    var can_chat_2_mem: Int!
    var chat_usrs_4_females : [String]!
    var chat_usrs_4_males : [String]!
    var cur_srv_ip : String!
    var free_chnl_vers : [String]!
    var guess_coin_lists : [String]!
    
    var openfire_domain : String!
    var openfire_ip : String!
    var openfire_port : String!
    
    var price_member_lists : [String]!
    var price_vip_lists : [String]!
    
    var slogan : String!
    
    var url_path_1 : String!
    var url_path_2 : String!
    var url_path_3 : String!
    var url_path_aliyun : String!
    
    var male_video_price: Int!
    var male_audio_price: Int!
    var female_video_price: Int!
    var female_audio_price: Int!
    var dating_apply_price:Int! // 赴约所需金币
    
    var is_dial_audio:Bool = true
    var is_dial_video:Bool = true

    
    func getConfig(_ callback:@escaping RequestCallBack) {
        biz.getConfig { (data, error) in
            if error == nil{
                self.update(validNSDictionary(validNSDictionary(data)[kConfig]))
                self.delegate?.refreshUI(self)
                callback(data,error)
            } else {
                debugPrint("getConfig 失败")
                SSTProgressHUD.showErrorWithStatus(validString(error))
            }
        }
    }
    override func mapping(map: Map) {
        super.mapping(map: map)

    }
    
    func update(_ dict: NSDictionary) {

        let configDict = validDictionary(dict[kConfig])
        self.can_chat_2_mem = validInt(configDict[kCan_chat_2_mem])
        
        var tchat_usrs_4_females = [String]()
        for chat_usrs_4_female in validNSArray(configDict[kChat_usrs_4_female]) {
            tchat_usrs_4_females.append(validString(chat_usrs_4_female))
        }
        chat_usrs_4_females = tchat_usrs_4_females
        
        var tchat_usrs_4_males = [String]()
        for chat_usrs_4_male in validNSArray(configDict[kChat_usrs_4_male]) {
            tchat_usrs_4_males.append(validString(chat_usrs_4_male))
        }
        chat_usrs_4_males = tchat_usrs_4_males
        
        
        self.cur_srv_ip = validString(configDict[kCur_srv_ip])
       
        var tfree_chnl_vers = [String]()
        for free_chnl_ver in validNSArray(configDict[kFree_chnl_ver]) {
            tfree_chnl_vers.append(validString(free_chnl_ver))
        }
        free_chnl_vers = tfree_chnl_vers
        
        var tguess_coin_lists = [String]()
        for guess_coin_list in validNSArray(configDict[kGuess_coin_list]) {
            tguess_coin_lists.append(validString(guess_coin_list))
        }
        guess_coin_lists = tguess_coin_lists
        
        self.openfire_domain = validString(configDict[kOpenfire_domain])
        self.openfire_ip = validString(configDict[kOpenfire_ip])
        self.openfire_port = validString(configDict[kOpenfire_port])
        
        var tprice_member_lists = [String]()
        for price_member_list in validNSArray(configDict[kPrice_member_list]) {
            tprice_member_lists.append(validString(price_member_list))
        }
        price_member_lists = tprice_member_lists
        
        var tprice_vip_lists = [String]()
        for price_vip_list in validNSArray(configDict[kPrice_vip_list]) {
            tprice_vip_lists.append(validString(price_vip_list))
        }
        price_vip_lists = tprice_vip_lists
        
        self.slogan = validString(validDictionary(dict[kSlogan])[kSlogan])
        
        let urlpaths = validDictionary(dict[kUrlpaths])
        
        self.url_path_1 = validString(urlpaths[kUrl_path_1])
        self.url_path_2 = validString(urlpaths[kUrl_path_2])
        self.url_path_3 = validString(urlpaths[kUrl_path_3])
        self.url_path_aliyun = validString(urlpaths[kUrl_path_aliyun])
        
        self.female_video_price = validInt(configDict[kfemale_video_price])
        self.male_audio_price = validInt(configDict[kmale_audio_price])
        self.male_video_price = validInt(configDict[kmale_video_price])
        self.female_audio_price = validInt(configDict[kfemale_audio_price])
        self.dating_apply_price = validInt(configDict[kdating_apply_price])
        
//        self.is_dial_video = validBool((configDict[kis_dial_video]))
//        self.is_dial_audio = validBool((configDict[kis_dial_audio]))
        
        
       
        setUserDefautsData(kis_dial_video, value: self.is_dial_video)
        setUserDefautsData(kis_dial_audio, value: self.is_dial_audio)
        setUserDefautsData(kis_dial_video, value: "1")
        setUserDefautsData(kis_dial_audio, value: "1")
        print("self.slogan"+self.slogan)
        
        biz.config = self
        setUserDefautsData(kSlogan, value: self.slogan)
    }
}
