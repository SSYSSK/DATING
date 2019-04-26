//
//  DATChoseInfoVC.swift
//  DATING
//
//  Created by 天星 on 17/5/10.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChoseInfoVC: DATBaseTVC {
    var indexPathNow = IndexPath()
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var ageFrom = "-1"
    var ageTo = "-1"
    var heightFrom = "-1"
    var heightTo = "-1"
    var inputFrom = "-1"
    var inputTo = "-1"
    var province = ""
    var city = ""
    var chooseInfoBlock:((_ ageFrom: String, _ ageTo: String, _ heightFrom: String, _ heightTo: String, _ inputFrom: String, _ inputTo: String, _ province:String, _ city:String) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 3 {
            indexPathNow = indexPath
            performSegueWithIdentifier(.SegueToProvinceVC, sender: nil)

        }else {
            indexPathNow = indexPath
            performSegueWithIdentifier(.SegueToTableView, sender: nil)

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func enterAction(_ sender: Any) {
        if let block = chooseInfoBlock  {
            block(ageFrom, ageTo, heightFrom, heightTo ,inputFrom ,inputTo, province, city)
        }
        _ =  navigationController?.popViewController(animated: true)
    }
}
// MARK: -- segue delegate
extension DATChoseInfoVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case SegueToTableView         = "toTableView"
        case SegueToProvinceVC         = "toProvinceVC"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if indexPathNow.row == 0 {
            let destVC = segue.destination as! DATEditInfoTableVC
            destVC.editType = .ages
            destVC.chooseInfoBlock = { [unowned self] (info) in
                self.ageLabel.text = "年龄：\(validString(info))"
                if validString(info) == "不限" {
                    self.ageFrom = "-1"
                    self.ageTo = "-1"
                }else if(validString(info).range(of: "以上") != nil) {
                    self.ageFrom = "35"
                    self.ageTo = "-1"
                }else {
                    let from = validString(info).sub(start: 0, end: 1)
                    let to = validString(info).sub(start: 3, end: 4)
                    self.ageFrom = from
                    self.ageTo = to
                }
            }
        }
        if indexPathNow.row == 1 {
            let destVC = segue.destination as! DATEditInfoTableVC
            destVC.editType = .heightss
            destVC.chooseInfoBlock = { [unowned self] (info) in
                self.heightLabel.text = "身高：\(validString(info))"
                if validString(info) == "不限" {
                    self.heightFrom = "-1"
                    self.heightTo = "-1"
                }else if(validString(info).range(of: "以下") != nil) {
                    self.heightFrom = "－1"
                    self.heightTo = "155"
                }else {
                    let from = validString(info).sub(start: 0, end: 2)
                    let to = validString(info).sub(start: 4, end: 6)
                    self.heightFrom = from
                    self.heightTo = to
                }
            }
        }
        if indexPathNow.row == 2 {
            let destVC = segue.destination as! DATEditInfoTableVC
            destVC.editType = .moneyInput
            destVC.chooseInfoBlock = { [unowned self] (info) in
                self.inputLabel.text = "收入：\(validString(info))"
                if validString(info) == "保密" {
                    self.inputFrom = "-1"
                    self.inputTo = "-1"
                }else if(validString(info).range(of: "以下") != nil) {
                    self.inputFrom = "－1"
                    self.inputTo = "2000"
                }else {
                    let str:NSString = validString(info) as NSString
                    let substringArry = str.components(separatedBy: "-");
                    let from = validString(substringArry[0])
                    let to = validString(substringArry[1])
                    self.inputFrom = from
                    self.inputTo = to
                }
            }
        }
//        if indexPathNow.row == 3 {
//            let destVC = segue.destination as! DATChoseProvinceVC
//            
//            destVC.chooseInfoBlock = { [unowned self] (info) in
//                self.inputLabel.text = "收入：\(validString(info))"
//                if validString(info) == "保密" {
//                    self.inputFrom = "-1"
//                    self.inputTo = "-1"
//                }else if(validString(info).range(of: "以下") != nil) {
//                    self.inputFrom = "－1"
//                    self.inputTo = "2000"
//                }else {
//                    let str:NSString = validString(info) as NSString
//                    let substringArry = str.components(separatedBy: "-");
//                    let from = validString(substringArry[0])
//                    let to = validString(substringArry[1])
//                    self.inputFrom = from
//                    self.inputTo = to
//                }
//            }
//        }
    }
}

