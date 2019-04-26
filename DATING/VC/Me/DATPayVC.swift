//
//  DATPayVC.swift
//  DATING
//
//  Created by 天星 on 17/5/12.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATPayVC: DATBaseTVC {
    var price = 0
    var content = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            print("100")
            price = 11
            content = "充值100金币"
            performSegueWithIdentifier( .SegueToChosePayWayVC, sender: nil)
        case 1:
            print("300")
            price = 33
            content = "充值300金币"
            performSegueWithIdentifier( .SegueToChosePayWayVC, sender: nil)
        case 2:
            print("1000")
            price = 100
            content = "充值1000金币"
            performSegueWithIdentifier( .SegueToChosePayWayVC, sender: nil)
        case 3:
            print("5000")
            price = 500
            content = "充值5000金币"
            performSegueWithIdentifier( .SegueToChosePayWayVC, sender: nil)
        case 4:
            print("10000")
            price = 1000
            content = "充值10000金币"
            performSegueWithIdentifier( .SegueToChosePayWayVC, sender: nil)

        default:
            print("---")
        }
        
    }
}

// MARK: -- segue delegate
extension DATPayVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToChosePayWayVC         = "toChosePayWayVC"

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! DATChosePayWayVC
        destVC.price = self.price
        destVC.content = self.content
    }
}

