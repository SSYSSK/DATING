//
//  DATCheatsVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/3/30.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
import MJRefresh
let kDATCheatCell = "DATCheatCell"
class DATCheatsVC: DATBaseVC {
    fileprivate var sectionsExpanded = [Int]()
    @IBOutlet weak var tableView: UITableView!
    fileprivate var emptyView = loadNib("\(SSTDataEmptyView.classForCoder())") as! SSTDataEmptyView
    
    var cheatData = DATCheatData()
    var clickUser = DATUser()
    override func viewDidLoad() {
        super.viewDidLoad()

        SSTProgressHUD.show()
        cheatData.delegate = self
        cheatData.getFriendList()

        tableView.register(UINib(nibName: kDATCheatCell, bundle: nil), forCellReuseIdentifier: kDATCheatCell)

        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.cheatData.getFriendList()
        })
        emptyView.frame = CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64)
        emptyView.setData(imgName: "icon_load", msg: "关注列表为空", buttonTitle: "刷新", buttonVisible: false)
        emptyView.isHidden = true
        emptyView.buttonClick = {
            self.cheatData.getFriendList()
        }
        self.tableView.addSubview(emptyView)
        
        //接受通知监听
        NotificationCenter.default.addObserver(self, selector:#selector(didMsgRecv), name: NSNotification.Name(rawValue: kReloadDataNotification), object: nil)
    }
    
    func didMsgRecv(){
        cheatData.getFriendList()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DATCheatsVC:  UITableViewDataSource,UITableViewDelegate {
    
    func clickedTableViewHeaderView(_ button: UIButton) {
        let section: Int = button.tag
        print("section=====\(section)")
        if sectionsExpanded.contains(section) {
            for ind in 0 ..< sectionsExpanded.count {
                if validInt(sectionsExpanded.validObjectAtIndex(ind)) == section {
                    sectionsExpanded.remove(at: ind)
                    break
                }
            }
        } else {
            sectionsExpanded.append(section)
        }
        
        if section == 1 {
            if  self.cheatData.blacks.count > 0 {
             tableView.reloadSections(IndexSet(integer: section), with: UITableViewRowAnimation.automatic)
            }
        }else {
            tableView.reloadSections(IndexSet(integer: section), with: UITableViewRowAnimation.automatic)
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle != UITableViewCellEditingStyle.delete) {
            return
        }else {
            print("删除")
            let alertController = UIAlertController(title: "确认删除？",
                                                    message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                
                if indexPath.section == 0 {
                    
                    let user = self.cheatData.friends[indexPath.row]
                    biz.user?.deleteFriend(user: user, { (data, error) in
                        let seccsion = NIMSession(validString(user.login_name), type: NIMSessionType.P2P)
                        let message = NIMMessage()
                        message.from = validString(biz.user?.login_name)
                        message.text = "对方已经把你从关注列表中删除"
                        
                        // 发送一条网页消息
                        
                        try? NIMSDK.shared().chatManager.send(message, to: seccsion)

                        self.cheatData.getFriendList()
                        
                        
                    })
                    
                }else if indexPath.section == 1{
                    
                    let user = self.cheatData.blacks[indexPath.row]
                    biz.user?.deleteFriend(user: user, { (data, error) in
                        self.cheatData.getFriendList()
                    })
                    
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionsExpanded.contains(section) {
            if section == 0 {
                return cheatData.friends.count
            }
            if section == 1 {
                return cheatData.blacks.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        
        let tempV = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
            let textlabel = UILabel(frame: CGRect(x: 15, y: 10, width: kScreenWidth-20, height: 20))
            textlabel.font = UIFont.systemFont(ofSize: 15)
        
        if section == 0 {
            textlabel.text = "我的好友"
        }
        else {
            textlabel.text = "黑名单"
        }
        tempV.addSubview(textlabel)
            
        let iamgeView = UIImageView()
        if sectionsExpanded.contains(section) {
            iamgeView.frame = CGRect(x: kScreenWidth-25, y: 16, width: 15, height: 7)
            iamgeView.image = UIImage(named:kIconExpandImageName)
        } else {
        iamgeView.frame = CGRect(x: kScreenWidth-20, y: 13, width: 7, height: 14)
            iamgeView.image = UIImage(named: kIconGoInImageName);
        }
        tempV.addSubview(iamgeView)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        button.addTarget(self, action: #selector(clickedTableViewHeaderView(_:)), for: UIControlEvents.touchUpInside)
        button.tag = section
        tempV.addSubview(button)
        
        let linelabel = UILabel(frame: CGRect(x: 0, y: 39, width: kScreenWidth, height: 1))
        linelabel.backgroundColor = UIColor.groupTableViewBackground
        
        tempV.addSubview(linelabel)
            
        headerView.addSubview(tempV)
        headerView.backgroundColor = RGBA(222, g: 222, b: 222, a: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell = tableView.dequeueReusableCell(withIdentifier: kDATCheatCell) as? DATCheatCell
        if cell == nil {
            cell = loadNib(kDATCheatCell) as? DATCheatCell
        }
        if indexPath.section == 0 {
            cell?.user = cheatData.friends[indexPath.row]
        }else {
            
            cell?.user = cheatData.blacks[indexPath.row]
            
        }
        return cell!
        
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            clickUser = cheatData.friends[indexPath.row]
            performSegue(withIdentifier: SegueIdentifier.SegueToUserDetailVC.rawValue, sender: nil)
        }else {
           
            clickUser = cheatData.blacks[indexPath.row]
            performSegue(withIdentifier: SegueIdentifier.SegueToUserDetailVC.rawValue, sender: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
// MARK: -- segue delegate
extension DATCheatsVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToUserDetailVC         = "toUserDetailVC"
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! DATUserDetailVC
        destVC.user = clickUser
      
    }
}



// MARK: - SSTUIRefreshDelegate

extension DATCheatsVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        
        SSTProgressHUD.dismiss()
        sectionsExpanded.removeAll()
        if (data as? DATCheatData) != nil {
            if let tmpData = data as? DATCheatData {
                self.cheatData = tmpData
                
                emptyView.isHidden = self.cheatData.friends.count > 0 || self.cheatData.blacks.count > 0
                tableView.reloadData()
                
                if self.cheatData.friends.count > 0 {
                    let button = UIButton()
                    button.tag = 0
                    self.clickedTableViewHeaderView(button)
                }
                if self.cheatData.blacks.count > 0 {
                    let button = UIButton()
                    button.tag = 1
                    self.clickedTableViewHeaderView(button)
                }
            }
           self.tableView.mj_header.endRefreshing()
        }  else {
           self.tableView.mj_header.endRefreshing()
        }
        
    }
}

