//
//  DATChatDetailVC.swift
//  DATING
//
//  Created by 天星 on 17/6/16.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
enum ChatType {
    case defaultValue
    case message
    case video
    case audio
}
class DATChatDetailVC: NTESSessionViewController {
    var backButton: UIButton?
    var user = DATUser()
    var chattype:ChatType = .defaultValue
    var message:String = ""
    let moreView = loadNib("DATChatMoreView") as! DATChatMoreView
    
    func addLeftItemButton() -> Void {
        
        backButton = UIButton(type: UIButtonType.custom)
        backButton?.frame = kBackButtonRect
        backButton?.addTarget(self, action: #selector(clickedBackBarButton), for: UIControlEvents.touchUpInside)
        
        backButton?.setImage(UIImage(named:kIconBackImgName), for: UIControlState())
        backButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 15)
        
        if let tmpButton = backButton {
            self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: tmpButton)
        }
    }
    func clickedBackBarButton() -> Void {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if validInt(self.navigationController?.viewControllers.count) > 1 {
            addLeftItemButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftItemButton()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]

        self.hidesBottomBarWhenPushed = true
        self.giftArray = NSMutableArray()
        self.myPrice = validString(biz.user?.money)
        if let data = biz.giftData {
            for gift in data.gifts {
                let dict = NSMutableDictionary()
                dict["icon"] = gift.giftIcon
                dict["name"] = gift.giftName
                dict["price"] = gift.price
                print("dict======\(dict)")
                self.giftArray.add(dict)
            }
        }
       
        switch chattype {
        case .defaultValue:
            print("默尔聊天")
        case .message:
            print("打招呼")
        case .video:
            print("视频聊天")
            let item = NIMMediaItem("onTapMediaItemVideoChat:", normalImage: UIImage(named:"btn_bk_media_video_chat_normal"), selectedImage: UIImage(named:"btn_bk_media_video_chat_pressed"), title: "视频聊天")
            self.openMediaItemVideoChat(item)
        case .audio:
            print("语音聊天")
            let item = NIMMediaItem("onTapMediaItemAudioChat:", normalImage: UIImage(named:"btn_media_telphone_message_normal"), selectedImage: UIImage(named:"btn_media_telphone_message_pressed"), title: "实时语音")
            self.openMediaItemAudioChat(item)
        default:
            print("---default ")
        }
        
        
        moreView.buttonActionBlock = { type in
            self.moreView.isHidden = true
            if type == "1" {
                print("self.session=\(self.session)")
                NIMSDK.shared().conversationManager.deleteAllmessages(in: self.session, removeRecentSession: true)

            }
            if type == "2" {
                self.performSegueWithIdentifier(.SegueToReportVC, sender: nil)
            }
        }
        moreView.frame = CGRect(x: kScreenWidth - 170, y: 64, width: 150, height: 69)
        moreView.isHidden = true
        self.view.addSubview(moreView)
    }

    //送礼物
    override func deletePrice(_ dict: NSMutableDictionary!, block: ((String?) -> Void)!) {
        let price = validInt(dict["price"])
        print("price=====\(price)")
        if price == 0 {
            block("0")
        }else {
            user.consumeForSendGift(price: price) { (data, error) in
                if error == nil {
                    block("0")
                }else {
                    block("1")
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    
    }
    
    override func enterMoreCard(_ sender: Any!) {
        moreView.isHidden = !moreView.isHidden
    }
    
    override func deleteMoney(_ type: TType, time: Int32, block: (() -> Void)!) {
        switch type.rawValue {
        case 0:
            print("视频聊天扣费")
            print("type.rawValue==\(type.rawValue)")
            user.consume(type: TType.init(0), time: time, { (data, error) in
                let dict = validDictionary(data)
                print("前＝＝＝＝＝\(validInt(validDictionary(dict["consume"])["coin_qty"]))")
                biz.user?.money = validInt(validDictionary(dict["consume"])["coin_qty"])
                if validInt(biz.user?.money) < 3 {
                    block()
                    
                    // 充会员
                    let dateView = loadNib("DATVIPView") as!  DATVIPView
                    dateView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
                    dateView.messageLabel.text = "你的金币余额不足，视频通话已停止，请充值！"
                    dateView.enterEventBlock = {
                        // 跳转充值界面
                        self.performSegue(withIdentifier: "toPayVC", sender: nil)
                    }
                    self.view.addSubview(dateView)
                }
            })
           
        case 1:
            print("语音聊天扣费")
            print("type.rawValue==\(type.rawValue)")
            user.consume(type: TType.init(0), time: time, { (data, error) in
                let dict = validDictionary(data)
                print("前＝＝＝＝＝\(validInt(validDictionary(dict["consume"])["coin_qty"]))")
                biz.user?.money = validInt(validDictionary(dict["consume"])["coin_qty"])
                if validInt(biz.user?.money) < 3 {
                    block()
                    // 充会员
                    let dateView = loadNib("DATVIPView") as!  DATVIPView
                    dateView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
                    dateView.messageLabel.text = "你的金币余额不足，语音通话已停止，请充值！"
                    dateView.enterEventBlock = {
                        // 跳转充值界面
                        self.performSegue(withIdentifier: "toPayVC", sender: nil)
                    }
                    self.view.addSubview(dateView)
                }
            })
        default:
            print("--")
        }

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DATChatDetailVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        moreView.isHidden = true
    }
}

// MARK: -- segue delegate
extension DATChatDetailVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToReportVC         = "toReportVC"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToReportVC:
            debugPrint("-----")
            let destVC = segue.destination as! DATReportVC
            destVC.user = self.user
        }
    }
}

