
//
//  DATBaseVC.swift
//  DATING
//
//  Created by 天星 on 17/3/31.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

let kBackButtonRect = CGRect(x: 0, y: 0, width: 25, height: 28)

// MARK: - SegueHandlerType

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegueWithIdentifier(_ identifier:SegueIdentifier, sender:AnyObject?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(_ segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            printDebug("Error: Invalid Segue Identifier: \(segue.identifier)")
            return SegueIdentifier(rawValue: "")!
        }
        return segueIdentifier
    }
}

class DATBaseVC: UIViewController {

    
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
        

        // 设置导航栏的背景颜色
//        self.navigationController?.navigationBar.barTintColor = RGBA(207, g: 77, b: 69, a: 1)
//        UINavigationBar.appearance().barTintColor = UIColor.red
        // 设置导航栏标题的字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if validInt(self.navigationController?.viewControllers.count) > 1 {
            addLeftItemButton()
        }
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationController?.navigationBar.tintColor = UIColor.white.withAlphaComponent(0.7)
        
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
