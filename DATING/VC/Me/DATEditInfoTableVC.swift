//
//  DATEditInfoTableVC.swift
//  DATING
//
//  Created by 天星 on 17/4/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
enum EditInfoType: String {
    case sex
    case education
    case makeingFriends //  交友目的
    case loveStrong // 恋爱专场
    case loveLook //爱情观
    case marriageLook // 婚姻观
    case isCanDistantlove // 是否接受异地恋
    case isCandoLovebeforeMarriage // 是否接受婚前性行为
    case height // 选择身高
    case wight // 选择体重
    case marriageMessage // 婚姻转狂
    case moneyInput // 月均收入
    case hasHome // 住房情况
    case hasCar // 是否购车
    case like // 兴趣爱好
    case character // 性格特征
    case ages
    case heightss
    
    case payway // 付费方式
    case userType // 用户类型
    case appointTitle // 用户类型
    case resionType
}


let kDATEditInfoTableCell = "DATEditInfoTableCell"
class DATEditInfoTableVC: DATBaseTVC {
    var editType:EditInfoType = .sex
    
    let sex = ["男","女"] // 性别
    let educations = ["小学","初中","高中","本科","硕士","博士"] // 学历
    let makeingFriends = ["结婚对象","恋人","短期关系","普通朋友","知己"] //交友目的
    let isCanDistantlove = ["能","看情况","不能"] //是否能接受异地恋 是否能接受婚前性行为
    let marriageMessages = ["未婚","已婚","离异","分居","丧偶"] //婚姻转狂
    let moneyInputs = ["2000以下","2000-3000","3000-5000","5000-8000","10000-20000","20000-50000","50000以上","保密"] //月均收入
    
    let hasHomes = ["自有物业","和家人同住","租房","婚后购房"]
    let hasCars = ["公共交通工具","自驾车－经济型","自驾车－中档型","自驾车－豪华型"]
    
    //筛选条件数据
    let ages = ["不限","18~22岁","23~26岁","27~30岁","31~35岁","35岁以上"]
    let heightss = ["不限","155cm以下","156~160cm","161~165cm","166~170cm","171~180cm"]
    let inputs = ["不限","155cm以下","156~160cm","161~165cm","166~170cm","171~180cm"]
    
    let payways = ["发起者付款","AA制"]
    let usertypes = ["所有用户","非会员","会员"]
    let resions = ["辱骂他人","敏感消息","广告骚扰","侵权","传播色情","欺诈骗钱","其他"]
    var appointTitles = [String]()
    var loveStrongs = NSMutableArray()
    var loveLooks = NSMutableArray()
    var marriageLooks = NSMutableArray()
    
    var heights = NSMutableArray()
    var wights = NSMutableArray()
    var likes = NSMutableArray()
    var characters = NSMutableArray()
    
    
    var chooseInfoBlock:((_ info: String) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        switch editType {
        case .sex:
            self.navigationController?.title = "性别"
        case .education:
            self.navigationController?.title = "学历"
        case .makeingFriends:
            self.navigationController?.title = "交友目的"
        case .loveStrong:
            self.navigationController?.title = "恋爱专长"
            let diaryList:String = Bundle.main.path(forResource: "LoveStrong", ofType:"plist")!
            loveStrongs = NSMutableArray(contentsOfFile:diaryList)!
        case .loveLook:
            self.navigationController?.title = "爱情观"
            let diaryList:String = Bundle.main.path(forResource: "LoveLook", ofType:"plist")!
            loveLooks = NSMutableArray(contentsOfFile:diaryList)!
        case .marriageLook:
            self.navigationController?.title = "婚姻观"
            let diaryList:String = Bundle.main.path(forResource: "MarriageLook", ofType:"plist")!
            marriageLooks = NSMutableArray(contentsOfFile:diaryList)!
        case .isCanDistantlove:
            self.navigationController?.title = "是否接受异地恋"
        case .isCandoLovebeforeMarriage:
            self.navigationController?.title = "是否接受婚前性行为"
        case .height:
            self.navigationController?.title = "身高"
            for  he in 140 ... 200 {
                heights.add(he)
            }
        case .wight:
            self.navigationController?.title = "体重"
            for  he in 30 ... 150 {
                wights.add(he)
            }
        case .marriageMessage:
            self.navigationController?.title = "婚姻状况"
        case .moneyInput:
            self.navigationController?.title = "月均收入"
        case .hasHome:
            self.navigationController?.title = "住房情况"
        case .hasCar:
            self.navigationController?.title = "是否购车"
        case .like:
            self.navigationController?.title = "兴趣爱好"
            let diaryList:String = Bundle.main.path(forResource: "like", ofType:"plist")!
            likes = NSMutableArray(contentsOfFile:diaryList)!
        case .character:
            self.navigationController?.title = "性格特征"
            let diaryList:String = Bundle.main.path(forResource: "Character", ofType:"plist")!
            characters = NSMutableArray(contentsOfFile:diaryList)!
        case .ages:
            self.navigationController?.title = "年龄"
        case .heightss:
            self.navigationController?.title = "身高"
        case .payway:
            self.navigationController?.title = "选择付费方式"
        case .userType:
            self.navigationController?.title = "选择用户类型"
        case .appointTitle:
            self.navigationController?.title = "选择约会标题"
        default:
            print("---")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch editType {
        case .sex:
            return sex.count
        case .education:
            return educations.count
        case .makeingFriends:
            return makeingFriends.count
        case .loveStrong:
            return loveStrongs.count
        case .loveLook:
            return loveLooks.count
        case .marriageLook:
            return marriageLooks.count
        case .isCanDistantlove:
            return isCanDistantlove.count
        case .isCandoLovebeforeMarriage:
            return isCanDistantlove.count
        case .height:
            return heights.count
        case .wight:
            return wights.count
        case .marriageMessage:
            return marriageMessages.count
        case .moneyInput:
            return moneyInputs.count
        case .hasHome:
            return hasHomes.count
        case .hasCar:
            return hasCars.count
        case .like:
            return likes.count
        case .character:
            return characters.count
        case .ages:
            return ages.count
        case .heightss:
            return heightss.count
        case .payway:
            return payways.count
        case .userType:
            return usertypes.count
        case .appointTitle:
            return appointTitles.count
        case .resionType:
            return resions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kDATEditInfoTableCell, for: indexPath) as! DATEditInfoTableCell
        switch editType {
        case .sex:
            cell.nameLabel.text = sex[indexPath.row]
        case .education:
            cell.nameLabel.text = educations[indexPath.row]
        case .makeingFriends:
            cell.nameLabel.text = makeingFriends[indexPath.row]
        case .loveStrong:
            cell.nameLabel.text = loveStrongs[indexPath.row] as? String
        case .loveLook:
            cell.nameLabel.text = loveLooks[indexPath.row] as? String
        case .marriageLook:
            cell.nameLabel.text = marriageLooks[indexPath.row] as? String
        case .isCanDistantlove:
            cell.nameLabel.text = isCanDistantlove[indexPath.row]
        case .isCandoLovebeforeMarriage:
            cell.nameLabel.text = isCanDistantlove[indexPath.row]
        case .height:
            cell.nameLabel.text = "\(heights[indexPath.row]) cm"
        case .wight:
            cell.nameLabel.text = "\(wights[indexPath.row]) kg"
        case .marriageMessage:
            cell.nameLabel.text = marriageMessages[indexPath.row]
        case .moneyInput:
            cell.nameLabel.text = moneyInputs[indexPath.row]
        case .hasHome:
            cell.nameLabel.text = hasHomes[indexPath.row]
        case .hasCar:
            cell.nameLabel.text = hasCars[indexPath.row]
        case .like:
            cell.nameLabel.text = likes[indexPath.row] as? String
        case .character:
            cell.nameLabel.text = characters[indexPath.row] as? String
        case .ages:
            cell.nameLabel.text = ages[indexPath.row]
        case .heightss:
            cell.nameLabel.text = heightss[indexPath.row]
        case .payway:
            cell.nameLabel.text = payways[indexPath.row]
        case .userType:
            cell.nameLabel.text = usertypes[indexPath.row]
        case .appointTitle:
            cell.nameLabel.text = appointTitles[indexPath.row]
        case .resionType:
            cell.nameLabel.text = resions[indexPath.row]

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var info = ""
        switch editType {
        
        case .sex:
            info = sex[indexPath.row]
        case .education:
            info = educations[indexPath.row]
        case .makeingFriends:
            info = makeingFriends[indexPath.row]
        case .loveStrong:
            info = validString(loveStrongs[indexPath.row])
        case .loveLook:
            info = validString(loveLooks[indexPath.row])
        case .marriageLook:
            info = validString(marriageLooks[indexPath.row])
        case .isCanDistantlove:
            info = isCanDistantlove[indexPath.row]
        case .isCandoLovebeforeMarriage:
            info = isCanDistantlove[indexPath.row]
        case .height:
            info = "\(heights[indexPath.row]) cm"
        case .wight:
            info = "\(wights[indexPath.row]) kg"
        case .marriageMessage:
            info = marriageMessages[indexPath.row]
        case .moneyInput:
            info = moneyInputs[indexPath.row]
        case .hasHome:
            info = hasHomes[indexPath.row]
        case .hasCar:
            info = hasCars[indexPath.row]
        case .like:
            info = validString(likes[indexPath.row])
        case .character:
            info = validString(characters[indexPath.row])
        case .ages:
            info = validString(ages[indexPath.row])
        case .heightss:
            info = validString(heightss[indexPath.row])
        case .payway:
            info = validString(payways[indexPath.row])
        case .userType:
            info = validString(usertypes[indexPath.row])
        case .appointTitle:
            info = validString(appointTitles[indexPath.row])
        case .resionType:
            info = validString(resions[indexPath.row])
        }
        if let block = chooseInfoBlock  {
            block(info)
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
