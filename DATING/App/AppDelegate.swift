//
//  AppDelegate.swift
//  DATING
//
//  Created by 林丽萍 on 2017/3/29.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

let biz = BizRequestCenter()
weak var gMainNC: UINavigationController?

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate,NIMLoginManagerDelegate {
    
    var gDeviceTokenString = ""
    
    var window: UIWindow?

   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupKeyBoardMananger()
        
        WXApi.registerApp(kWX_APP_ID)

        NIMSDK.shared().register(withAppID: "6260a2ea34f509ea84976b9ed151bd68", cerName: "appcer")
        
        let option = NIMSDKOption(appKey: appkey)
        option.apnsCername      = "" // APNS 推送证书名
        option.pkCername        = ""//Pushkit 证书名
        NIMSDK.shared().register(with: option)
        
        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder())
        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig())
        SSTProgressHUD.setup()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        return true
    }
    
//    func setupServices(){
//        NTESLogManager.shared().start()
//        NTESNotificationCenter.sharedCenter().start()
//        NTESSubscribeManager.sharedManager.start()
//    }
//
//    func setupNIMSDK(){
//        NTESLogManager.shared().start()
//        NTESNotificationCenter.sharedCenter().start()
//        NTESSubscribeManager.sharedManager.start()
//    }

    
    /**
     配置键盘管理
     */
    fileprivate func setupKeyBoardMananger() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false     // set the toolbar hidden above the keyboard
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        
        for i in 0..<deviceToken.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        debugPrint("Device Token:", tokenString)
        gDeviceTokenString = tokenString
        let userDefault = UserDefaults.standard
        userDefault.set(tokenString, forKey: kDeviceToken)
        userDefault.synchronize()
        
        if gDeviceTokenString.isNotEmpty {
//            biz.uploadPushDeviceToken(gDeviceTokenString) { (data, error) in
//                if error != nil {
//                    SSTProgressHUD.showInfoWithStatusOnlyForDEV("Fail from API for uploading Device Token: \(validString(error))")
//                }
//            }
            
            NIMSDK.shared().updateApnsToken(deviceToken)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        SSTProgressHUD.showInfoWithStatusOnlyForDEV("Fail to register notification: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        handleActionAfterReceiveNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if application.applicationState == UIApplicationState.inactive || application.applicationState == UIApplicationState.background {
            handleActionAfterReceiveNotification(userInfo)
        }else if application.applicationState == UIApplicationState.active  {
            debugPrint("active＝＝＝＝＝＝＝  弹窗 ")
        }
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        handleActionAfterReceiveNotification(userInfo)
    }
    func handleActionAfterReceiveNotification(_ userInfo: [AnyHashable: Any]) {
        let info = validDictionary(userInfo)
        
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: PayResp.classForCoder()) {
            let response = resp as! PayResp
            switch response.errCode {
            case WXSuccess.rawValue:
                print("支付成功")
            default:
                print("支付失败")
            }
        }
    }
    
}
