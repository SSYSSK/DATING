
//
//  DATMyInfoVC.swift
//  DATING
//
//  Created by 天星 on 17/4/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATMyInfoVC: DATBaseTVC {
    var indexPathNow = IndexPath()
    let user = biz.user
    
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var britydayText: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var qqText: UITextField!
    @IBOutlet weak var wxText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var dubaiText: UITextField!
    @IBOutlet weak var educationText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var manegerText: UITextField!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var houseText: UITextField!
    @IBOutlet weak var carText: UITextField!
    @IBOutlet weak var likeText: UITextField!
    @IBOutlet weak var characterText: UITextField! //性格特征
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user?.delegate = self
        self.setData()
    }
    
    @IBAction func saveUserInfo(_ sender: Any) {
        SSTProgressHUD.show()

        user?.nickname = nickName.text
        user?.qq_no = qqText.text
        user?.wx_no = wxText.text
        user?.phone = phoneText.text
        user?.heart_words = dubaiText.text
        
        if validString(user?.wx_no) == "" {
            SSTProgressHUD.showErrorWithStatus("微信不能为空")
        }else {
            user?.updateUserBase(userTmp: user!)
        }
    }
    
    func setData(){
        nickName.text = user?.nickname
        britydayText.text = user?.birtyday
        
        sex.text = user?.sexStr
        
        qqText.text = user?.qq_no
        wxText.text = user?.wx_no
        phoneText.text = user?.phone
        weightText.text = "\(validString(user?.wight)) kg"
        educationText.text = user?.diploma
        addressText.text = validString("\(validString(user?.province)) \(validString(user?.city))")
        heightText.text = validString(user?.height)
        manegerText.text = user?.marriage
        if validInt(user?.salary_to) == -1 {
            inputText.text = "\(validInt(user?.salary_fm)) 以上"
        }else if validInt(user?.salary_fm) == -1 {
            inputText.text = "\(validInt(user?.salary_to)) 以下"
        }else if validInt(user?.salary_fm) == -1 || validInt(user?.salary_to) == -1 {
            inputText.text = "保密"
        }
        houseText.text = user?.apartment
        carText.text = user?.vehicle
        likeText.text = user?.like
        characterText.text = user?.personality
        dubaiText.text = user?.heart_words
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        view.backgroundColor = RGBA(239, g: 239, b: 244, a: 1)
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: kScreenWidth - 20, height: 30))
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        view.addSubview(label)
        
        if section == 0 {
            label.text = "基本信息"
        }else {
            label.text = "修改信息"
        }
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        indexPathNow = indexPath
        if indexPath.section == 1 && indexPath.row == 1 {
            
            
            
            let dateView = loadNib("ChoseBrithdayView") as!  ChoseBrithdayView
            dateView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 44)
            dateView.hiddlenActionBlock = { date in

                self.britydayText.text = date
                self.user?.birtyday = date
            }
            window.addSubview(dateView)
        }else  if indexPath.section == 1 &&  indexPath.row == 5 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }else  if indexPath.section == 1 &&  indexPath.row == 6 {
            performSegueWithIdentifier(.SegueToProvinceVC, sender: nil)
        }
        else  if indexPath.section == 1 &&  indexPath.row == 7 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
        else  if indexPath.section == 1 &&  indexPath.row == 8 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
       else  if indexPath.section == 1 &&  indexPath.row == 9 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
        else  if indexPath.section == 1 &&  indexPath.row == 10 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
        else  if indexPath.section == 1 &&  indexPath.row == 11 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
        else  if indexPath.section == 1 &&  indexPath.row == 12 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
        else  if indexPath.section == 1 &&  indexPath.row == 13 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
        else  if indexPath.section == 1 &&  indexPath.row == 14 {
            performSegueWithIdentifier(.SegueToTableView, sender: nil)
        }
    }

}

// MARK: -- segue delegate
extension DATMyInfoVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToBrithday         = "toBrithday"
        case SegueToTableView         = "toTableView"
        
        case SegueToProvinceVC         = "toProvinceVC"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToBrithday:
            debugPrint("-----")
            let brithdayVC = segue.destination as! DATEditBrithdayVC
            brithdayVC.brithday = validString(biz.user?.birtyday)
            brithdayVC.chooseBrithdayBlock = { [unowned self] (date) in
                self.britydayText.text = date
                self.user?.birtyday = date
            }
        case .SegueToProvinceVC:
            if indexPathNow.section == 1 && indexPathNow.row == 6 {
                let destVC = segue.destination as! DATChoseProvinceVC
                destVC.chooseInfoBlock = { [unowned self] (province, city) in
                    self.addressText.text = "\(province) \(city)"
                }
            }
        case .SegueToTableView:
            debugPrint("-----")
            if indexPathNow.section == 1 && indexPathNow.row == 5 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .education
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.educationText.text = info
                    self.user?.diploma = info
                }

            }
            
            if indexPathNow.section == 1 && indexPathNow.row == 7 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .height
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.heightText.text = info
                    self.user?.height = validInt(info)
                }
            }

            if indexPathNow.section == 1 && indexPathNow.row == 8 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .wight
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.weightText.text = info
                    self.user?.wight = validInt(info)
                }
            }
            if indexPathNow.section == 1 && indexPathNow.row == 9 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .marriageMessage
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.manegerText.text = info
                    self.user?.marriage = validString(info)
                }
            }
            if indexPathNow.section == 1 && indexPathNow.row == 10 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .moneyInput
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.inputText.text = info
                    let str:NSString = validString(info) as NSString
                    let substringArry = str.components(separatedBy: "-");
                    if substringArry.count > 1 {
                        let from = validInt(substringArry[0])
                        let to = validInt(substringArry[1])
                        self.user?.salary_fm = from
                        self.user?.salary_to = to
                    }else {
                        if validString(info) == "50000以上" {
                            let from = 5000
                            let to = -1
                            self.user?.salary_fm = from
                            self.user?.salary_to = to
                        }else if validString(info) == "2000以下"{
                            let from = -1
                            let to = 2000
                            self.user?.salary_fm = from
                            self.user?.salary_to = to
                        }else {
                            self.user?.salary_fm = -1
                            self.user?.salary_to = -1
                        }
                    }
                }
            }
            if indexPathNow.section == 1 && indexPathNow.row == 11 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .hasHome
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.houseText.text = info
                    self.user?.apartment = validString(info)
                }
                
            }
            if indexPathNow.section == 1 && indexPathNow.row == 12 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .hasCar
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.carText.text = info
                    self.user?.vehicle = validString(info)
                }
                
            }
            if indexPathNow.section == 1 && indexPathNow.row == 13 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .like
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.likeText.text = info
                    self.user?.like = validString(info)
                }

            }
            if indexPathNow.section == 1 && indexPathNow.row == 14 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .character
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.characterText.text = info
                    self.user?.personality = validString(info)
                }
            }
        }
       
    }
}

// MARK: - SSTUIRefreshDelegate

extension DATMyInfoVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        self.tableView.reloadData()
    }
}
