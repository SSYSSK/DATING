//
//  DATUserAlbums.swift
//  DATING
//
//  Created by 天星 on 17/4/10.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kFile_id = "file_id"
let kfile_type = "file_type"
let kname = "name"
let kurl = "url"
let kurl_folder = "url_folder"
let kurl_thum = "url_thum"
class DATUserAlbums: BaseModel {
    var file_id: String!
    var file_type: String!
    var name: String!
    var url: String!
    var url_folder: String!
    var url_thum: String!
    func setUserAlbums(array:Array<AnyObject>) -> [DATUserAlbums] {
        var userAlbums = [DATUserAlbums]()
        for dict in array {
            let tdict = validDictionary(dict)
            
            let userAlbum = DATUserAlbums()
            
            userAlbum.file_id = validString(tdict[kFile_id])
            userAlbum.file_type = validString(tdict[kfile_type])
            userAlbum.name = validString(tdict[kname])
            userAlbum.url = validString(tdict[kurl])
            userAlbum.url_folder = validString(tdict[kurl_folder])
            userAlbum.url_thum = validString(tdict[kurl_thum])
            userAlbums.append(userAlbum)
        }
        
        return userAlbums
    }
    
    
    func update(_ tdict: NSDictionary) -> DATUserAlbums{
        let userAlbums = DATUserAlbums()
        userAlbums.file_id = validString(tdict[kFile_id])
        userAlbums.file_type = validString(tdict[kfile_type])
        userAlbums.name = validString(tdict[kname])
        userAlbums.url = validString(tdict[kurl])
        userAlbums.url_folder = validString(tdict[kurl_folder])
        userAlbums.url_thum = validString(tdict[kurl_thum])
        return userAlbums
    }
}
