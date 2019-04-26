//
//  DATHomeData.swift
//  DATING
//
//  Created by 天星 on 17/4/11.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kUsersData = "users"
class DATHomeData: BaseModel {
    var users = [DATUser]()
    
    override init() {
        super.init()
        if let dict = FileOP.unarchive(kHomeFileName) {
            self.update(validDictionary(dict))
        }
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    func fetchData() {
        biz.getHomePage(rec_seq: 0) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
                FileOP.archive(kHomeFileName, object: validNSDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
    func beginfetchData() {
        biz.getbeginHomePage(rec_seq: 0) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
                FileOP.archive(kHomeFileName, object: validNSDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
    func uploadRefresh(rec_seq: Int) {
        print("rec_seq=====\(rec_seq)")
        biz.getHomePage(rec_seq: rec_seq) { (data, error) in
            if error == nil && data != nil {
                self.uploadUpdate(validDictionary(data))
                FileOP.archive(kHomeFileName, object: validDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }
    
    func searchData(rec_seq: Int, ageFrom:Int, ageTo:Int, heightFrom:Int, heightTo:Int, inputFrom:Int, inputTo:Int, province:String, city:String) {
        biz.searchHomePage(rec_seq: rec_seq, ageFrom: ageFrom, ageTo: ageTo, heightFrom: heightFrom, heightTo: heightTo, salary_rangeFrom: inputFrom, salary_rangeTo: inputTo, province:province, city:city) { (data, error) in
            if error == nil && data != nil {
                self.update(validDictionary(data))
                FileOP.archive(kHomeFileName, object: validDictionary(data))
                self.delegate?.refreshUI(self)
            } else {
                self.delegate?.refreshUI(error)
            }
        }
    }

    
    func uploadUpdate(_ dict:  Dictionary<String,Any>) {
        let users = validArray(dict[kUsersData])
        for userDict in users {
            let user = DATUser()
            user.update(validNSDictionary(userDict))
            self.users.append(user)
        }
        print(self.users)
        
    }

    
    func update(_ dict:  Dictionary<String,Any>) {
        var usersT = [DATUser]()
        let users = validArray(dict[kUsersData])
        for userDict in users {
            let user = DATUser()
            user.update(validNSDictionary(userDict))
            //user.update(validNSDictionary(validNSDictionary(userDict)[kUser]))
            usersT.append(user)
        }
        self.users = usersT
        print(self.users)

    }
    
   }
