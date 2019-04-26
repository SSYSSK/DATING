//
//  DATBaseTVC.swift
//  DATING
//
//  Created by 天星 on 17/4/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit


class DATBaseTVC: UITableViewController {
    var backButton: UIButton?
    var networkErrorTipView: SSTErrorTipView!
    
    // 收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if networkErrorTipView == nil {
            networkErrorTipView = loadNib("\(SSTErrorTipView.classForCoder())") as? SSTErrorTipView
            networkErrorTipView?.frame = CGRect(x: 0, y: kScreenNavigationHeight, width: kScreenWidth, height: 39)
            networkErrorTipView?.message = kInternetConnectionNotAvialable
        }

        // 设置导航栏标题的字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]

        if validInt(self.navigationController?.viewControllers.count) > 1 {
            addLeftItemButton()
        }

        TaskUtil.delayExecuting(1) {
//            self.showErrorTipView()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(_:)), name: NSNotification.Name(rawValue: kNetworkStatusNofication), object: nil)
    }
    
    func showErrorTipView() {
        if biz.ntwkAccess.networkIsAvailable == false {
            self.view.addSubview(networkErrorTipView)
        } else {
            self.networkErrorTipView.removeFromSuperview()
        }
    }
    
    func fetchData() {}
    
    func networkChanged(_ notification: Notification) {
        showErrorTipView()
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        backButton?.removeFromSuperview()
        SSTProgressHUD.dismiss()
    }
    
    func addLeftItemButton() -> Void {
        
        backButton = UIButton(type: UIButtonType.custom)
        backButton?.frame = kBackButtonRect
        backButton?.addTarget(self, action: #selector(clickedBackBarButton), for: UIControlEvents.touchUpInside)
        
        backButton?.setImage(UIImage(named:kIconBackImgName), for: UIControlState())
        backButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 15)
        
        if let tmpButton = backButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: tmpButton)
        }
    }
    
    func clickedBackBarButton() -> Void {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
