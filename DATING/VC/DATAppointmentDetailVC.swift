//
//  DATAppointmentDetailVC.swift
//  DATING
//
//  Created by 天星 on 17/5/26.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//




import UIKit
import MJRefresh

let kDATAppointmentDetailInfoCell = "DATAppointmentDetailInfoCell"
let kDATAppointmentDetailUserCell = "DATAppointmentDetailUserCell"

class DATAppointmentDetailVC: DATBaseVC {
    var appointment = DATAppointment()
    
    @IBOutlet weak var fuyue: UIButton!
    @IBOutlet weak var changeaAppment: UIButton!
    @IBOutlet weak var deleteAppment: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var reflushAppointmentBlock:(() ->Void)?
    var clickUser = DATUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: kDATAppointmentDetailInfoCell, bundle: nil), forCellReuseIdentifier: kDATAppointmentDetailInfoCell)
        tableView.register(UINib(nibName: kDATAppointmentDetailUserCell, bundle: nil), forCellReuseIdentifier: kDATAppointmentDetailUserCell)
        appointment.delegate = self
        appointment.getDetail(dating_id: validInt(appointment.datingId),login_name:validString(appointment.loginName))
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.appointment.getDetail(dating_id: validInt(self.appointment.datingId),login_name:validString(self.appointment.loginName))
        })
    }
    
    @IBAction func changeAppmentAction(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.SegueToChangeAppointmentVC.rawValue, sender: nil)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        self.appointment.deleteAppointment(dating_id: validInt(appointment.datingId)) { (data, error) in
            if error == nil {
                SSTProgressHUD.showSuccessWithStatus("删除成功")
                TaskUtil.delayExecuting(1, block: {
                    self.reflushAppointmentBlock?()
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }else {
                SSTProgressHUD.showSuccessWithStatus("删除失败")
            }

        }
    }
    
    @IBAction func fuyueEvent(_ sender: Any) {
        
        //判断是否会员才可以参加，如果是，判断自己是不是会员，如果不是，弹出窗
        if appointment.type == 1 {
            if biz.user?.is_chat == 1 {
                DATAppointment().datingApply(dating_id: validInt(appointment.datingId), { (data, error) in
                    if error == nil {
                        SSTProgressHUD.showSuccessWithStatus("申请参加成功")
                        TaskUtil.delayExecuting(1, block: {
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }else {
                        SSTProgressHUD.showSuccessWithStatus(validString(validDictionary(error)["message"]))
                    }
                })
            }else {
                // 充会员
                let dateView = loadNib("DATVIPView") as!  DATVIPView
                dateView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
                dateView.enterEventBlock = {
                    // 跳转充值界面
                    self.performSegueWithIdentifier(.SegueToPayVC, sender: nil)
                }
                self.view.addSubview(dateView)

            }
        }else {
            DATAppointment().datingApply(dating_id: validInt(appointment.datingId), { (data, error) in
                if error == nil {
                    SSTProgressHUD.showSuccessWithStatus("申请参加成功")
                    TaskUtil.delayExecuting(1, block: {
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                }else {
                    SSTProgressHUD.showSuccessWithStatus(validString(validDictionary(error)["message"]))
                }
            })
        }
    }
}

extension DATAppointmentDetailVC: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        }else {
            return validInt(self.appointment.applys?.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            tableView.tableFooterView = UIView(frame: CGRect())
            var cell = tableView.dequeueReusableCell(withIdentifier: kDATAppointmentDetailInfoCell) as? DATAppointmentDetailInfoCell
            if cell == nil {
                cell = loadNib(kDATAppointmentDetailInfoCell) as? DATAppointmentDetailInfoCell
            }
    
            if indexPath.row == 0 {
                cell?.keyLabel.text = "主题:"
                cell?.valueLabel.text = appointment.title
            }
            if indexPath.row == 1 {
                cell?.keyLabel.text = "约会时间:"
                cell?.valueLabel.text = validString(appointment.datingTime)
            }
            if indexPath.row == 2 {
                cell?.keyLabel.text = "约会地址:"
                
                cell?.valueLabel.text = appointment.address
                
                if validString(appointment.address) == "" {
                    cell?.valueLabel.text = "\(validString(appointment.province)) \(validString(appointment.city))"
                }
                
            }
            if indexPath.row == 3 {
                cell?.keyLabel.text = "省份:"
                cell?.valueLabel.text = appointment.province
            }
            if indexPath.row == 3 {
                cell?.keyLabel.text = "约会性别:"
//                1 女  0 男
                if validString(appointment.psex) == "1" {
                    cell?.valueLabel.text = "女"
                }else if validString(appointment.psex) == "0" {
                    cell?.valueLabel.text = "男"
                }else {
                    cell?.valueLabel.text = "不限"
                }
            }
            if indexPath.row == 4 {
                cell?.keyLabel.text = "用户类型:"
                if validString(appointment.type) == "-1" {
                    cell?.valueLabel.text = "所有用户"
                }else if validString(appointment.type) == "0" {
                    cell?.valueLabel.text = "非会员"
                }else {
                    cell?.valueLabel.text = "会员"
                }
            }
            if indexPath.row == 5 {
                cell?.keyLabel.text = "付费方式:"
                cell?.valueLabel.text = appointment.payment
            }
            if indexPath.row == 6 {
                cell?.keyLabel.text = "约会内容:"
                cell?.valueLabel.text = appointment.title
            }
            return cell!
        }else {
            //            let cell = tableView.dequeueReusableCell(withIdentifier: kDATAppointmentDetailUserCell, for: indexPath)  as! DATAppointmentDetailUserCell
            var cell = tableView.dequeueReusableCell(withIdentifier: kDATAppointmentDetailUserCell) as? DATAppointmentDetailUserCell
            if cell == nil {
                cell = loadNib(kDATAppointmentDetailUserCell) as? DATAppointmentDetailUserCell
            }
            cell?.user = appointment.applys?[indexPath.row]
            print("loginname===\(appointment.applys?[indexPath.row].login_name)")
            print("loginname===\(appointment.applys?[indexPath.row].nickname)")
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
            view.backgroundColor = RGBA(239, g: 239, b: 244, a: 1)
            let label = UILabel(frame: CGRect(x: 10, y: 0, width: kScreenWidth - 20, height: 40))
            label.text = "  "
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.gray
            view.addSubview(label)
            return view
        }else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }else {
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            if let user = appointment.applys?[indexPath.row] {
                clickUser = user
                performSegue(withIdentifier: SegueIdentifier.SegueToUserDetailVC.rawValue, sender: nil)
            }
        }
    }
}

// MARK: -- segue delegate
extension DATAppointmentDetailVC: SegueHandlerType {
    enum SegueIdentifier: String {
        case SegueToUserDetailVC         = "toUserDetailVC"
        case    SegueToPayVC      = "toPayVC"
        case SegueToChangeAppointmentVC = "toChangeAppointmentVC"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToUserDetailVC:
            let destVC = segue.destination as! DATUserDetailVC
            print("clickUser.login_name===\(clickUser.login_name)")
            print("clickUser.nickname===\(clickUser.nickname)")
            destVC.user = clickUser
        case .SegueToPayVC:
            print("--")
        case .SegueToChangeAppointmentVC:
            let destVC = segue.destination as! DATSendAppointmentVC
            destVC.appointment = self.appointment
            destVC.type = .change
        }
    }
}

// MARK: - SSTUIRefreshDelegate
extension DATAppointmentDetailVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        self.tableView.mj_header.endRefreshing()
        if (data as? DATAppointment) != nil {
            if let tmpData = data as? DATAppointment {
                appointment = tmpData
                print("appointment.user_id===\(validString(appointment.loginName))")
                print("biz.user?.user_id===\(validString(biz.user?.login_name))")
                
                if validString(appointment.loginName) == validString(biz.user?.login_name) {
                    fuyue.isHidden = true
                    changeaAppment.isHidden = false
                    deleteAppment.isHidden = false
                }else {
                    fuyue.isHidden = false
                    changeaAppment.isHidden = true
                    deleteAppment.isHidden = true
                }
            }
        }
        self.tableView.reloadData()
    }
}
