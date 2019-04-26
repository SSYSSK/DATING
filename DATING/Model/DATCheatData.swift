//
//  DATCheatData.swift
//  DATING
//
//  Created by 天星 on 17/7/28.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kBlacks = "blacks"
let kFriends = "friends"
class DATCheatData: BaseModel {
    
    
    var friends = [DATUser]()
    var blacks = [DATUser]()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }

    func update(_ dict:  Dictionary<String,Any>) {
        var friendsT = [DATUser]()
        var blakcsT = [DATUser]()
        
        let blakcs = validArray(dict[kBlacks])
        let friends = validArray(dict[kFriends])
        for userDict in friends {
            print(userDict)
            let user = DATUser()
            user.update(validNSDictionary(userDict))
            
            friendsT.append(user)
        }
        self.friends = friendsT
        
        for userDict in blakcs {
            print(userDict)
            let user = DATUser()
            user.update(validNSDictionary(userDict))
            //user.update(validNSDictionary(validNSDictionary(userDict)[kUser]))
            blakcsT.append(user)
        }
        self.blacks = blakcsT
        biz.cheatData = self
        print(self)
    }
    func getFriendList(){
        var operation:[String:Any] = [String:Any]()
        var param:[String:Any] = [String:Any]()
        
        operation["module"] = "user"
        operation["action"] = "user_friend_list"
        
        var user:[String:Any] = [String:Any]()
        user["login_name"] = biz.user?.login_name
        param["user"] = user
        biz.getFriendList(param: param, operation: operation) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
                self.delegate?.refreshUI(self)
                
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }

}
