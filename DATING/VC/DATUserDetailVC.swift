//
//  DATUserDetailVC.swift
//  DATING
//
//  Created by 天星 on 17/5/4.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kHomeDailyDealsItemVWidth = Int(kScreenWidth/4)
class DATUserDetailVC: DATBaseTVC {
    var user = DATUser()
    var stringArr:[String] = ["嗨，约吗","你好，我很倾慕你，聊聊可以吗","嗨，做个朋友呗","你好啊"]
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dubaiLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var menagerLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var hasCarLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var xinggeLabel: UILabel!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var buttone: UIButton!
    @IBOutlet weak var b: UIButton!
    
    var images = [String]()
    var session = NIMSession()
    var message = ""
    var chattype:ChatType = .defaultValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SSTProgressHUD.show()

        user.getUserDetail(userTmp: user)
        user.delegate = self

        self.tableView.rowHeight = UITableViewAutomaticDimension
        buttone.setTitle("关注", for: UIControlState.normal)

        self.isFriend()
        self.isBlack()
 
    }

    
    @IBAction func lokkqq(_ sender: Any) {
        
    }
    
    @IBAction func lookwx(_ sender: Any) {
        
    }
    
    func isFriend(){
        if let friends = biz.cheatData?.friends {
            for user in friends {
                if user.user_id == self.user.user_id {
                    buttone.setTitle("发送消息", for: UIControlState.normal)
                }
            }
        }
    }
    
    func isBlack(){
        if let friends = biz.cheatData?.blacks {
            for user in friends {
                
                if user.user_id == self.user.user_id {
                    b.setTitle("移出黑名单", for: UIControlState.normal)
                }
            }
        }
    }
    
    @IBAction func blackEvent(_ sender: Any) {
        let buttontmp = sender as! UIButton
        if buttontmp.titleLabel?.text == "移出黑名单" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadDataNotification), object: nil, userInfo: nil)
            biz.user?.deleteBalck(user: self.user, { (data, error) in
                if error == nil {
                    self.b.setTitle("拉黑", for: UIControlState.normal)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadDataNotification), object: nil, userInfo: nil)
                }
            })
        }
        if buttontmp.titleLabel?.text == "拉黑" {
            // 拉黑
            biz.user?.addBalck(user: self.user, { (data, error) in
                if error == nil {
                    self.b.setTitle("移出黑名单", for: UIControlState.normal)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadDataNotification), object: nil, userInfo: nil)
                }
            })
        }
    }

    @IBAction func chatEnter(_ sender: Any) {
        
        print(validString(user.login_name))
        
        let seccsion = NIMSession(validString(user.login_name), type: NIMSessionType.P2P)
//        let seccsion = NIMSession("a02", type: NIMSessionType.P2P)
        
       
//        let chatVC = NIMSessionViewController(session: seccsion)
        
        session = seccsion
        performSegue(withIdentifier: "toDATChatDetailVC", sender: nil)

//        let chatVC = DATChatDetailVC(session: seccsion)
//        self.navigationController?.pushViewController(chatVC!, animated: true)
        
    }
    
    @IBAction func chatAction(_ sender: Any) {

        let seccsion = NIMSession(validString(user.login_name), type: NIMSessionType.P2P)
//        let seccsion = NIMSession("a02", type: NIMSessionType.P2P)
        session = seccsion
        performSegue(withIdentifier: "toDATChatDetailVC", sender: nil)
        //let chatVC = DATChatDetailVC(session: seccsion)
                
        //随机获取消息
        //1:下面是使用arc4random函数求一个1~100的随机数（包括1和100）
        
        let num = arc4random_uniform(UInt32(stringArr.count))
        if num < UInt32(stringArr.count) {
            message = stringArr[validInt(num)]

        }else {
            message = stringArr[0]
        }
    }
    @IBAction func buttonEvent(_ sender: Any) {
        let buttontmp = sender as! UIButton
        
        if buttontmp.titleLabel?.text == "发送消息" {
            let alertVC = UIAlertController(title: "", message: "选择聊天方式", preferredStyle: UIAlertControllerStyle.actionSheet)
            let acSure = UIAlertAction(title: "视频聊天", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                if self.user.is_rcv_video == false {
                    SSTProgressHUD.showInfoWithStatus("对方设置了视频免打扰")
                }else {
                    self.chattype = .video
                    let seccsion = NIMSession(validString(self.user.login_name), type: NIMSessionType.P2P)
                    self.session = seccsion
                    self.performSegue(withIdentifier: "toDATChatDetailVC", sender: nil)
                }
                
            }
            if self.user.is_rcv_video == true {
                acSure.setValue(UIColor.blue, forKey: "titleTextColor")
                
            }
            if self.user.is_rcv_video == false{
                acSure.setValue(RGBA(123, g: 123, b: 123, a: 1), forKey: "titleTextColor")
                
            }
            
            let acSure1 = UIAlertAction(title: "语音聊天", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                if self.user.is_rcv_audio == false {
                    SSTProgressHUD.showInfoWithStatus("对方设置了语音免打扰")
                }else {
                    let seccsion = NIMSession(validString(self.user.login_name), type: NIMSessionType.P2P)
                    self.session = seccsion
                    self.chattype = .audio
                    self.performSegue(withIdentifier: "toDATChatDetailVC", sender: nil)
                }
            }
            
            if self.user.is_rcv_audio == false {
                acSure1.setValue(RGBA(123, g: 123, b: 123, a: 1), forKey: "titleTextColor")
                
            }
            if self.user.is_rcv_audio == true {
                
                acSure1.setValue(UIColor.blue, forKey: "titleTextColor")
            }
            
            let acSure2 = UIAlertAction(title: "发消息", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                self.chattype = .message
                let seccsion = NIMSession(validString(self.user.login_name), type: NIMSessionType.P2P)
                self.session = seccsion
                let num = arc4random_uniform(UInt32(self.stringArr.count))
                if num < UInt32(self.stringArr.count) {
                    self.message = self.stringArr[validInt(num)]
                    
                }else {
                    self.message = self.stringArr[0]
                }
                
                self.performSegue(withIdentifier: "toDATChatDetailVC", sender: nil)
            }
            acSure2.setValue(UIColor.blue, forKey: "titleTextColor")
            let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
            }
            acCancel.setValue(UIColor.blue, forKey: "titleTextColor")
            alertVC.addAction(acSure)
            alertVC.addAction(acSure1)
            alertVC.addAction(acSure2)
            alertVC.addAction(acCancel)
            self.present(alertVC, animated: true, completion: nil)
        }else if buttontmp.titleLabel?.text == "关注"{
            // 添加关注
            biz.user?.addFriend(user: self.user, { (data, error) in
                if error == nil {
                    self.buttone.setTitle("发送消息", for: UIControlState.normal)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReloadDataNotification), object: nil, userInfo: nil)
                }
            })
        }
    }
    
    func setData(){
        print("哈哈哈哈")
        print(validString(user.birtyday))
        dubaiLabel.text = user.dating_advantage
        weightLabel.text = validString(user.wight)
        menagerLabel.text = user.marriage
        inputLabel.text = "\(validInt(user.salary_fm)) - \(validInt(user.salary_to))"
        houseLabel.text = user.apartment
        hasCarLabel.text = user.vehicle
        likeLabel.text = user.like
        xinggeLabel.text = user.personality
        scrollView.contentSize = CGSize(width: (kHomeDailyDealsItemVWidth + 5) * user.userAlbums.count + 5 , height: 98)
        if user.userAlbums.count > 0 {
            noImageLabel.isHidden = true
            images.removeAll()
            for index in 0 ..< user.userAlbums.count  {
                images.append(user.userAlbums[index].url)
                let userAlbum = user.userAlbums[index]
                let itemView = UIImageView()
                itemView.frame = CGRect(x: (kHomeDailyDealsItemVWidth + 5 ) * index + 5, y: 4, width: kHomeDailyDealsItemVWidth, height: 90)
                itemView.tag = index
                itemView.setImage(fileUrl: userAlbum.url_thum, placeholder: "ic_avatar_male")
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageEvent(_:)))
                itemView.isUserInteractionEnabled = true
                itemView.addGestureRecognizer(tapGesture)
                itemView.contentMode = UIViewContentMode.scaleAspectFill
                scrollView.addSubview(itemView)
            }
        }else {
            noImageLabel.isHidden = false
        }
        
    }

    func imageEvent(_ sender: UITapGestureRecognizer){
//        let imageView = sender.view
//        let ph = LXPhotoBrowserViewController(arr: validNSArray(user.userAlbums), index: IndexPath(row: validInt(imageView?.tag), section: 0))
//        self.present(ph, animated: true, completion: nil)
        print(images)
        //图片索引
        let index = sender.view!.tag
        //进入图片全屏展示
        let previewVC = ImagePreviewVC(images: images, index: index)
        self.navigationController?.pushViewController(previewVC, animated: true)

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 165
        }else {
            return 7
        }
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let view = loadNib("DATUserDetailTopView") as! DATUserDetailTopView
            view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 188)
            view.iconImageView.setImage(fileUrl: validString(user.main_picts_url_thum), placeholder: kIcon_loading)
            view.nameLABEL.text = user.nickname
            view.iconImageView.layer.masksToBounds = true
            view.iconImageView.contentMode = UIViewContentMode.scaleAspectFill
            view.iconImageView.layer.masksToBounds = true
            view.iconImageView.layer.cornerRadius = 0.22 * kScreenWidth / 2 //变圆形
            view.infoLabel.text = "\(validString(user.age))岁 ／ \(validString(user.height))cm"
            return view
        }else {
            return UIView()
        }
    }
}

// MARK: -- segue delegate
extension DATUserDetailVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToChatDetailVC         = "toDATChatDetailVC"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToChatDetailVC:
            let destVC = segue.destination as! DATChatDetailVC
            if message != "" {
              destVC.message = message
            }
            destVC.chattype = self.chattype
            destVC.session = session
            destVC.user = user
        }
    }
}

// MARK: - SSTUIRefreshDelegate
extension DATUserDetailVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        if (data as? DATUser) != nil {
            if let tmpData = data as? DATUser {
                self.user = tmpData
            }
        }
        setData()
    }
}
