//
//  DATChoseAppointmentInfoVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/7/8.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChoseAppointmentInfoVC: DATBaseTVC {
   
    var sex = -1
    var city = "不限"
    var province = "不限"
    
    var indexPathNow = IndexPath()
    
    @IBOutlet weak var keyworldTextField: UITextField!
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var chooseInfoBlock:((_ keyWorld: String, _ sex: String, _ province:String, _ city:String) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    @IBAction func searchEvent(_ sender: Any) {
//        if validString(keyworldTextField.text) == "" {
//            SSTProgressHUD.showErrorWithStatus("关键字不能为空")
//        }else {
//            chooseInfoBlock?(validString(keyworldTextField.text), validString(sex), province, city)
//            
//            self.navigationController?.popViewController(animated: true)
//        }
        chooseInfoBlock?(validString(keyworldTextField.text), validString(sex), province, city)
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func setCityValue(_ sender: Any) {
        province = validString(biz.province)
        city = validString(biz.city)
        
        cityLabel.text = "\(validString(biz.province)) \(validString(biz.city))"
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            indexPathNow = indexPath
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
            
        }
        if indexPath.row == 2 {
            indexPathNow = indexPath
            performSegueWithIdentifier(.SegueToProvinceVC, sender: nil)
            
        }
    }

}

// MARK: -- segue delegate
extension DATChoseAppointmentInfoVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case SegueToTableView         = "toTableView"
        case SegueToProvinceVC         = "toProvinceVC"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if indexPathNow.row == 1 {
            let destVC = segue.destination as! DATEditInfoTableVC
            destVC.editType = .sex
            destVC.chooseInfoBlock = { [unowned self] (info) in
                self.sexLabel.text = "\(validString(info))"
                if validString(info) == "不限" {
                    self.sex = -1
                }else if(validString(info) == "男") {
                    self.sex = 0
                }else if(validString(info) == "女") {
                    self.sex = 1
                }else {
                    self.sex = -1
                }
            }
        }
    }
}


