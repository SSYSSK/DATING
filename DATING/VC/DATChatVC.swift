//
//  DATChatVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/7/2.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChatVC: NIMSessionListViewController {
    
    var  session = NIMSession()
    var number = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏的背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
        // 设置导航栏标题的字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]

        
    }
    
    
   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false
        
        number = 0
        for  secssion in recentSessions {
            let s = secssion as! NIMRecentSession
            number = number + s.unreadCount
        }
        if validInt(number) > 0 {
            self.tabBarController?.childViewControllers[1].tabBarItem.badgeValue = validString(number)
        }else {
            self.tabBarController?.childViewControllers[1].tabBarItem.badgeValue = nil
        }
    }

    override func onSelectedRecent(_ recent: NIMRecentSession!, at indexPath: IndexPath!) {
        //super.onSelectedRecent(recent, at: indexPath)
        if let esc = recent.session {
            session = esc
            performSegue(withIdentifier: "toDATChatDetailVC", sender: nil)
        }
       
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

// MARK: -- segue delegate
extension DATChatVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SeguetToDATChatDetailVC         = "toDATChatDetailVC"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DATChatDetailVC
        destVC.session = session
        
    }
}
