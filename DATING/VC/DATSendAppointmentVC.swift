//
//  DATSendAppointmentVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/7/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
enum SendOrChange {
    case send
    case change
}

class DATSendAppointmentVC: DATBaseTVC {
    
    var titleText = ""
    var time = ""
    var sex = ""
    var payway = ""
    var city = "广东省  深圳市"
    var address = ""
        @IBOutlet weak var sixday: UIButton!
    @IBOutlet weak var threeTenDay: UIButton!
    @IBOutlet weak var tenDay: UIButton!
    @IBOutlet weak var senvenDay: UIButton!
    @IBOutlet weak var threeDay: UIButton!
    
    @IBOutlet weak var nv: UIButton!
    @IBOutlet weak var nan: UIButton!
    @IBOutlet weak var buxian: UIButton!
    
    @IBOutlet weak var faqizhe: UIButton!
    @IBOutlet weak var canjiazhe: UIButton!
    @IBOutlet weak var zaishangyi: UIButton!
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var type:SendOrChange = .send
    
    var appointment = DATAppointment()
    var appointmentData = DATAppointmentData()
    var indexPathNow = IndexPath()
    
    var reflushAppointmentBlock:(() ->Void)?

    var titles = [String]()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathNow = indexPath
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            if  self.titles.count < 1 {
                SVProgressHUD.showError(withStatus: "获取主题失败，请退出重试")
            }else {
                performSegue(withIdentifier: "toEditInfoVC", sender: nil)
            }
        }
        if indexPath.row == 4 {
            performSegue(withIdentifier: "toProvinceVC", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointment.getTitles { (data, error) in
            if error == nil {
                print("data===\(data)")
                let array = validArray(validDictionary(data)["dating_titles"])
                for dict in array {
                    let title = validString(validDictionary(dict)["enum_title"])
                    self.titles.append(title)
                }
//                self.titleLabel.text = self.titles.first
//                self.titleText = validString(self.titles.first)
            }
        }
        switch type {
        case .change:
            self.navigationController?.title =  "修改约会"
            switch validString(appointment.effect_days) {
            case "60":
                self.sixEvent(sixday)
            case "30":
                self.threeTenDayEvent(threeTenDay)
            case "10":
                self.tenDayEvent(tenDay)
            case "7":
                self.sevenDayEvent(senvenDay)
            case "3":
                self.threeEvent(threeDay)
            default:
                print("--")
            }

            switch validString(appointment.sex) {
            case "0":
                self.nanEvent(nan)
            case "1":
                self.nvEvent(nv)
            case "-1":
                self.buxianEvent(buxian)
            default:
                print("--")
            }
            switch validString(appointment.payment) {
            case "发起者":
                self.faqizheEvent(faqizhe)
            case "参加者":
                self.canjiazheEvent(canjiazhe)
            case "再商议":
                self.zaishangyi(zaishangyi)
            default:
                print("--")
            }
            self.cityLabel.text =  "\(validString(appointment.province)) \(validString(appointment.city))"

            self.titleLabel.text = appointment.title
            titleText = validString(appointment.title)
            city = validString(appointment.city)
        case .send:
//            self.title = "发布约会"
            self.navigationController?.title =  "发布约会"
            self.cityLabel.text = "\(validString(biz.province)) \(validString(biz.city))"
        }
        
        
        
    }
    @IBAction func setCityNomal(_ sender: Any) {
        city = "\(validString(biz.province)) \(biz.city)"
        cityLabel.text = "\(validString(biz.province)) \(validString(biz.city))"
    }
    
    func setDefaultColor(button:UIButton){
        time = validString(button.titleLabel?.text)
        sixday.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        threeTenDay.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        tenDay.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        senvenDay.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        threeDay.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        
    }
    
    func setSexDefaultColor(button:UIButton){
        if validString(button.titleLabel?.text) == "男" {
            sex = "0"
        }else if validString(button.titleLabel?.text) == "女"{
            sex = "1"
        }else {
            sex = "-1"
        }
        
        nv.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        nan.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        buxian.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
    }
    
    func setPaywayDefaultColor(button:UIButton){
        payway = validString(button.titleLabel?.text)
        faqizhe.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        canjiazhe.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
        zaishangyi.setTitleColor(RGBA(69, g: 69, b: 69, a: 1), for: UIControlState.normal)
    }
    
    @IBAction func sixEvent(_ sender: Any) {
        setDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }

    @IBAction func threeTenDayEvent(_ sender: Any) {
        setDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    @IBAction func tenDayEvent(_ sender: Any) {
        setDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    @IBAction func sevenDayEvent(_ sender: Any) {
        setDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)

    }
    @IBAction func threeEvent(_ sender: Any) {
        setDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    
    @IBAction func nvEvent(_ sender: Any) {
        setSexDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    
    @IBAction func nanEvent(_ sender: Any) {
        setSexDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    @IBAction func buxianEvent(_ sender: Any) {
        setSexDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    
    @IBAction func faqizheEvent(_ sender: Any) {
        setPaywayDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    
    @IBAction func canjiazheEvent(_ sender: Any) {
        setPaywayDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)

    }

    @IBAction func zaishangyi(_ sender: Any) {
        setPaywayDefaultColor(button: sender as! UIButton)
        (sender as! UIButton).setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    
    @IBAction func sendEvent(_ sender: Any) {
        guard validString(titleText) != "" else {
            SSTProgressHUD.showErrorWithStatus("请输入约会主题")
            return
        }
        appointment.title = validString(titleText)
        
        guard validString(time) != "" else {
            SSTProgressHUD.showErrorWithStatus("请选择约会有效期")
            return
        }
        appointment.datingTime = validString(time).replacingOccurrences(of: "天", with: "")
        
        guard validString(sex) != "" else {
            SSTProgressHUD.showErrorWithStatus("请选择性别")
            return
        }

        appointment.psex = validInt(sex)
        guard validString(payway) != "" else {
            SSTProgressHUD.showErrorWithStatus("请选择付费方式")
            return
        }
        appointment.payment = validString(payway)
        
        guard validString(city) != "" else {
            SSTProgressHUD.showErrorWithStatus("请选择城市")
            return
        }
        appointment.pcity = validString(city)

        // 充会员
        switch type {
        case .send:
            let alertController = UIAlertController(title: "发布约会需要扣除3个金币，是否发布？",
                                                    message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                biz.user?.consumeForSendAppointment(price: 3, { (data, error) in
                    let dict = validDictionary(data)
                    print("前＝＝＝＝＝\(validInt(validDictionary(dict["consume"])["coin_qty"]))")
                    if data == nil {
                        let dateView = loadNib("DATVIPView") as!  DATVIPView
                        dateView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
                        dateView.messageLabel.text = "你的金币余额不足，不能发布约会，请充值！"
                        dateView.enterEventBlock = {
                            // 跳转充值界面
                            self.performSegue(withIdentifier: "toPayVC", sender: nil)
                        }
                        self.view.addSubview(dateView)
                    }else {
                        biz.user?.money = validInt(validDictionary(dict["consume"])["coin_qty"])
                        
                        self.appointmentData.sendAppointment(appointment: self.appointment) { (data, error) in
                            if error != nil {
                                SSTProgressHUD.showErrorWithStatus("发布失败")
                            }else {
                                SSTProgressHUD.showSuccessWithStatus("发布成功")
                                self.reflushAppointmentBlock?()
                                _ = self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                })
                
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        case .change:
            self.appointmentData.changeAppointment(appointment: self.appointment) { (data, error) in
                if error != nil {
                    SSTProgressHUD.showErrorWithStatus(validString(validDictionary(error)["message"]))
                }else {
                    SSTProgressHUD.showSuccessWithStatus("修改成功")
                    self.reflushAppointmentBlock?()
                    for vc in (self.navigationController?.viewControllers)! {
                        if vc.isKind(of: DATAppointmentVC.classForCoder()) {
                            
                            _ = self.navigationController?.popToViewController(vc, animated: true)
                        }
                    }
                    
                }
            }

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DATSendAppointmentVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToTableView         = "toEditInfoVC"
        case SegueToPayVC         = "toPayVC"
        case SegueToProvinceVC         = "toProvinceVC"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {

        case .SegueToTableView:

            if indexPathNow.row == 0 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .appointTitle
                
                destVC.appointTitles = self.titles
                destVC.chooseInfoBlock = { [unowned self] (info) in
                  self.titleLabel.text = info
                    self.titleText = info
                }
            }
            if indexPathNow.row == 4 {
                let destVC = segue.destination as! DATChoseProvinceVC
                destVC.chooseInfoBlock = { [unowned self] (province, city) in
                    self.cityLabel.text = validString(city)
                    
                    self.city = validString(city)
                    self.address = "\(validString(province)) \(validString(city))"
                }
            }
        case .SegueToPayVC:
            print("-")
        case .SegueToProvinceVC:
            print("-")

        }
    }
}

