//
//  SSTAPPMacro.swift
//  sst-ios
//
//  Created by Amy on 16/4/20.
//  Copyright © 2016年 SST. All rights reserved.
//

import UIKit

//import ObjectMapper
import AudioToolbox
import AssetsLibrary
import Photos

//typealias Mapper = ObjectMapper.Mapper


let kBaseURLString       = "http://zhizhangren.cn:2099"
let kBaseSearchURLString = "https://search.sstparts.com/sst-solr/api/mobile/search/"
let kBaseImageURL        = "https://image.sstparts.com/thumb127x127/"
let kBaseImageSlidesUrl  = "https://image.sstparts.com/slides/"
let kPayURLString        = "https://billing.sstparts.com/sst-billing/"
let kPayPalClientId      = "AVic2Po0BaZNN4uCCWjnlZhZYGXqWsQ_OXy2Y_j3AI9B3Kui9ulpSiWtAqILEnx-Tm3sM-NOv4QgmO8O"

let kOpenfireLoginName      = "admin"  // 舞狐 easylove_861837032577192
let kDevice_no = "86603"  ////866032023633791 867516025125599  easylove_352107064761643

let kAlldevice_id = "2564"
let appkey = "6260a2ea34f509ea84976b9ed151bd68"

let chat = "a01"
let mini = 3 // 3分钟算一次
enum TabIndexType: Int {
    case home = 0
    case category = 1
    case deal = 2
    case cart = 3
    case more = 4
}

enum NotificationInfoType: Int {
    case search = 0
    case deal = 1
    case item = 2
    case web = 3
}

enum SlideInfoType: String {
    case Search = "search"
    case Link = "link"
    case Group = "group"
    case Product = "product"
    case Article = "article"
}

enum NotificationEnableStatus: String {
    case On = "On"
    case Off = "Off"
}

enum HomeSeeAllType: String {
    case deals = "Deals"
    case newArrival = "New arrivals"
    case featureProducts = "Featured products"
}

enum APICodeType: Int {
    case ok = 200
    case loginWithAnotherDevice = 507
    case notLogined = 508
}

// MARK: - Cache路径
public let kCachePath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!

//MARK:--屏幕大小
let kScreenBounds: CGRect   = UIScreen.main.bounds
let kScreenWidth            = UIScreen.main.bounds.size.width
let kScreenHeight           = UIScreen.main.bounds.size.height
let kScreenNavigationHeight = CGFloat(64)
let kProkScreenWidth        = UIScreen.main.bounds.size.width/375
let kProkScreenHeight       = UIScreen.main.bounds.size.height/667

//let RGBA(r, g, b, a) = UIColor(red: (r)/255.0, green: (g)/255.0, blue: 2(b)/255.0, alpha: (a))

//MARK:--设备尺寸
let currentModeSize = UIScreen.main.currentMode?.size
let iPhone4s = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? CGSize(width: 640, height: 960).equalTo(currentModeSize!) : false
let iPhone5 = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? CGSize(width: 640, height: 1136).equalTo(currentModeSize!) : false
let iPhone6 = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? CGSize(width: 750, height: 1334).equalTo(currentModeSize!) : false
let iPhone6Plus = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo(currentModeSize!) : false

let kNameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]

let kAppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let kAppBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

let NavigationH: CGFloat = 64
let HotViewMargin: CGFloat = 10
let ShopCarRedDotAnimationDuration: TimeInterval = 0.2
let kUserIdValue            = "1111"
let kSearchItemPageSize     = 10
let kSearchOrderPageSize    = 10
let kPageSize = 10
let kFontSize: CGFloat = 13

let kSearchSplitString      = "###"
let kCollectionCellSpacingFive: CGFloat = 1
let kOneInMillion = 0.000001
let OrderSource =  0 // 订单来源 ，0=官方，1=ebay

//
let kSearchBarPlaceholderText = "type in what you're searching for ..."
let Loading = "Loading..."

let kWX_APP_ID = "wx04beb2400f32e49d";

//网络请求超时限制
let kTimeoutInterval: Double    = 30
let kTimeoutForTest: Double     = 20

let kNowMessage       = "nowMessage.data"

//MARK:--缓存购物车的文件名
let kHomeFileName       = "home.data"
let kAppointmentFileName  = "home.appointment"
let kCategoryFileName   = "category.data"
let kCartFileName       = "cart.data"
let kAvatarFileName     = "avatar.data"
let kCountryFileName    = "countries.data"
let kPaypalConfirmationFileName = "paypal_confirmation.data"
let kUserFileName       = "user.data"
let kFavoriteFileName   = "favorite.data"
let kGuideFileName      = "guide.data"

//MAKR:--缓存图片名
let kIconBackImgName                = "icon_back_gray"
let kHomeSlidePlaceholderImgName    = "category_placeholder"
let kHomeDailyDealPlaceholder       = "dailyDeals1"
let kCategoryPlaceholderImgName     = "category_placeholder"
let kItemPlaceholderImgName         = "icon_itemDetail_default"
let kDefaultImageName               = "item_detail"
let kItemDetailPlaceholderImageName = "icon_item_default"
let kGuidePlaceholderImgName        = "LaunchImg"
let kIconGoInImageName              = "icon_goIn"
let kIconExpandImageName            = "icon_expand"
let kIconCollapseImageName          = "icon_collapse"

let KCategory_loading               = "category_loading"
let kIcon_loading                   = "icon_loading"
let kIcon_slide                     = "home_icon_slide"
let kIcon_badConnected              = "icon_badConnected"
//let kNotification = "notification"
//let kNotificationTime = "notificationTime"
//var kNotificationStatus = "ON"
let kNotificationLastPromptDate = "notificationDate"

let kUserNames = "login.userNames"

let pathOfCaches = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first

// 存储搜索关键字的历史记录
let kSearchHistoryKeywordsFileName = "SSTHistorySearchKeyword"
let kAppUserToken = "userToken"
let kUserTokenType = "tokenType" //true: userToken, false: guestToken
let kFirstName = "firstName" //user's first name

let kXMPPNewMessage = "kXMPPNewMessage"
let kAccountSignOutByAnotherDeviceTip = "Your account was login in another device, please sign in fisrt."
//let kBlueColor      = UIColor(red: 69.0/255.0, green: 132.0/255.0, blue: 244.0/255.0, alpha: 1)
let kSectionBgColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
let kLightGrayColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1)
let kDarkGaryColor  = UIColor(red: 130.0/255.0, green: 130.0/255.0, blue: 130.0/255.0, alpha: 1)
let kPurpleColor    = UIColor(red: 112.0/255.0, green: 111.0/255.0, blue: 252.0/255.0, alpha: 1)
let kPurpleBgClolor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 253.0/255.0, alpha: 1)
//系统时间
let kSystemDateKey       = "systemKey"

let kStoryBoard_Home     = "Home"
let kStoryBoard_Category = "Category"
let kStoryBoard_Deals    = "Deals"
let kStoryboard_Cart     = "Cart"
let kStoryBoard_More     = "More"
let kStoryBoard_Login    = "Login"
let kStoryBoard_Main     = "Main"

let kReloadDataNotification = "ReloadDataNotification"

//device token
let kDeviceToken = "deviceToken"

let kGuideDateLastViewed = "GuideDateLastViewed"    // for date last viewed guide to store
let kGuideAppPrevVersion = "GuideAppVersion"        // for app prev version to store to check app updated or not
let kOpenPhotoFailedText = "Failed to obtain photo"
enum ImageType {
    case localImageType,webImageType
}

enum SelectedTypeInCart:Int {
    case bestSellingType = 0, mostPopularType
}

//MARK: 快速生成颜色
func RGBA (_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//MARK:--手机震动
func SHAKEPHONE () {
    let soundID = SystemSoundID(kSystemSoundID_Vibrate)
    //振动
    AudioServicesPlaySystemSound(soundID)
}

func GET_StoryBoard (_ sbName : String) -> UIStoryboard {
    return UIStoryboard(name: sbName, bundle: Bundle.main)
}

func getProductImagePath(_ imagePath: String?) -> String {
    if imagePath == nil {
        return ""
    }
    return  kBaseImageURL + imagePath!
}

//根据Key获取UserDefault的内容
func getUserDefautsData(_ name: String) -> AnyObject? {
    return UserDefaults.standard.object(forKey: name) as AnyObject?
}
func setUserDefautsData(_ name: String, value: Any) {
    return UserDefaults.standard.set(value, forKey: name)
}

//给view添加阴影
func shadowView(_ view: UIView, height: CGFloat, direction: CGFloat) {
    view.layer.shadowOffset = CGSize(width: direction, height: height)
    view.layer.shadowOpacity = 0.4
    view.layer.shadowColor = UIColor.gray.cgColor
}

func toJsonString(_ object: Any) -> String {
    if let jsonData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted) {
        if let rString = String(data: jsonData, encoding: String.Encoding.utf8) {
            printDebug("JSON String: \(rString)")
            return rString
        }
    }
    return ""
}

func clearName(_ name: String) -> String {
    var resultName = name
    
    let invalidHtmlStrings = ["&amp;","amp;","amp"]
    for invalidString in invalidHtmlStrings {
        resultName = resultName.replacingOccurrences(of: invalidString, with: "&")
    }
    
    return resultName
}

func deleteUserName(userName:String) {
    var userNames = getUserNames()
    var userNamssTmp = userNames
    for i in 0 ..< userNames.count {
        if userNames[i] == userName {
            userNamssTmp.remove(at: i)
        }
    }
    if userNamssTmp.count > 0 {
        FileOP.archive(kUserNames, object: userNamssTmp)
    }
}

func setUserNames(userName:String) {
    var userNames = getUserNames()
    var userNamssTmp = userNames
    for i in 0 ..< userNames.count {
        if userNames[i] == userName {
            userNamssTmp.remove(at: i)
        }
    }
    userNamssTmp.append(userName)
    print("userNamssTmp==\(userNamssTmp)")
    FileOP.archive(kUserNames, object: userNamssTmp)
}

func getUserNames() -> [String] {
    var users = [String]()
    if let userNames = FileOP.unarchive(kUserNames) {
        users = userNames as! [String]
    }
    print("users==\(users)")
    return users
}

func isPhoneNumber(phoneNumber:String) -> Bool {
    if phoneNumber.characters.count == 0 {
        return false
    }
    let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
    let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if regexMobile.evaluate(with: phoneNumber) == true {
        return true
    }else
    {
        return false
    }
    
}
