//
//  DATChosePayWayVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/7/8.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChosePayWayVC: DATBaseTVC {
    var content:String?
    var price:Int = 0
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        contentLabel.text = validString(content)
        priceLabel.text = validString("¥\(price)元")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            let order = DATWXOrder()
            order.getWXPrepay(money: price * 100, message: validString(content)) { (data, error) in
                let dict = validNSDictionary(validNSDictionary(data)["payment"])
                let req = PayReq()
                req.partnerId = validString(dict["partnerId"])
                req.prepayId = validString(dict["prepay_id"])
                req.nonceStr = validString(dict["nonce_str"])
                req.timeStamp           = UInt32(validInt(dict["timestamp"]))
                req.package             = validString(dict["packageValue"])
                req.sign                = validString(dict["sign"])
                
                print(dict)
                
                WXApi.send(req)
            }
        }

        if indexPath.row == 2 {
            
        }
    }

}
