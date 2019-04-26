//
//  DATChoseProvinceVC.swift
//  DATING
//
//  Created by 天星 on 17/7/3.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATChoseProvinceVC: DATBaseTVC {
    
    var chooseInfoBlock:((_ province: String, _ city: String) ->Void)?
    var array = [DATProvince]()
    var provinceNow = DATProvince()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        let path = Bundle.main.path(forResource:"allprovinces", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let json:Any = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
            print(json)
            let datalist = json as? NSDictionary
            let arrayTmp = datalist?["provincesList"] as! [NSDictionary]
            
            for  dict in arrayTmp {
                let province = DATProvince().setDict(dict: dict)
                array.append(province)
            }
            self.tableView.reloadData()
            
        }catch let erro as Error! {
            print("读取本地数据出现错误！",erro)
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let province = array[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = province.name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let province = array[indexPath.row]
        provinceNow = province
        performSegue(withIdentifier: "toChoseCityVC", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DATChoseCityVC
        destVC.province = provinceNow
    }
    
}
