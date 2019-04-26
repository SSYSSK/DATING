//
//  DATChoseCityVC.swift
//  DATING
//
//  Created by 天星 on 17/7/3.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChoseCityVC: DATBaseTVC {

    var province = DATProvince()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return province.citys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = province.citys[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = city.name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = province.citys[indexPath.row]
        print(city.name)
        
        let vcs = self.navigationController?.viewControllers
        
        for vc in vcs! {
            if vc.isKind(of: DATSendAppointmentVC.classForCoder()) {
                let vcTmp = vc as! DATSendAppointmentVC
                vcTmp.cityLabel.text = "\(validString(province.name))   \(validString(city.name))"
                vcTmp.appointment.province = province.name
                vcTmp.appointment.pcity = city.name
                
                _ = self.navigationController?.popToViewController(vcTmp, animated: true)
            }
            
            if vc.isKind(of: DATChoseAppointmentInfoVC.classForCoder()) {
                let vcTmp = vc as! DATChoseAppointmentInfoVC
                vcTmp.cityLabel.text = "\(validString(province.name)) \(validString(city.name))"
                vcTmp.province = province.name
                vcTmp.city = city.name
                
                _ = self.navigationController?.popToViewController(vcTmp, animated: true)
            }
            
            //首页搜索条件
            if vc.isKind(of: DATChoseInfoVC.classForCoder()) {
                let vcTmp = vc as! DATChoseInfoVC
                vcTmp.province = province.name
                vcTmp.city = city.name
                vcTmp.cityLabel.text = "城市: \(validString(province.name)) \(validString(city.name))"
                _ = self.navigationController?.popToViewController(vcTmp, animated: true)
            }
            
            if vc.isKind(of: DATMyInfoVC.classForCoder()) {
                let vcTmp = vc as! DATMyInfoVC
                biz.user?.city = city.name
                biz.user?.province = province.name
                vcTmp.setData()
                
                _ = self.navigationController?.popToViewController(vcTmp, animated: true)
            }
        }
    }

}
