//
//  SSTBaseNavigationController.swift
//  sst-mobile
//
//  Created by Amy on 16/4/12.
//  Copyright © 2016年 lzhang. All rights reserved.
//

import UIKit

class SSTBaseNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.navigationBar.tintColor = UIColor.gray
        
        // 设置导航栏的背景颜色
//        self.navigationController?.navigationBar.barTintColor = RGBA(207, g: 77, b: 69, a: 1)
//        UINavigationBar.appearance().barTintColor = UIColor.red
//        // 设置导航栏标题的字体颜色
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: RGBA(255, g: 255, b: 255, a: 1), NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)]
        
        UINavigationBar.appearance().barTintColor = UIColor.red
         //设置导航栏标题的字体颜色
//                self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: RGBA(255, g: 255, b: 255, a: 1), NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]
        // 设置导航栏标题的字体颜色
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]

        // 设置interactivePopGestureRecognizer委托
        interactivePopGestureRecognizer?.delegate = self
        // 设置当前UINavigationController委托
        delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactivePopGestureRecognizer?.delegate = nil
        delegate = nil
    }
}

extension SSTBaseNC: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    /*
     func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
     if navigationController.viewControllers.count == 1 {
     currentShowVC = nil
     } else {
     currentShowVC = viewController
     }
     }
     
     func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
     if gestureRecognizer == interactivePopGestureRecognizer {
     return currentShowVC == topViewController
     }
     
     return true
     }
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
     return true
     //        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self) {
     //            return true
     //        } else {
     //            return false
     //        }
     }
     //    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
     //                           shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer:
     //        UIGestureRecognizer) -> Bool {
     //        return true
     //    }
     
     */
}
