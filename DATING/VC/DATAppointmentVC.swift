//
//  DATAppointmentVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/3/30.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
import MJRefresh
let kDATAppointmentcell = "DATAppointmentCell"

class DATAppointmentVC: DATBaseVC {

    var typeShow = 1
    
    var appointmentData = DATAppointmentData()
    var appointmentNow = DATAppointment()
    var rec_seq = 0
    var clickUser = DATUser()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventView: UIView!

    @IBOutlet weak var send: UIImageView!
    @IBOutlet weak var all: UIImageView!
    @IBOutlet weak var my: UIImageView!
    @IBOutlet weak var search: UIImageView!
    
    var type:appointmentSearch = .all
    
    var searchKey = ""
    var sex = ""
    var province = ""
    var city = ""
    
    var emptyView = loadNib("\(SSTDataEmptyView.classForCoder())") as! SSTDataEmptyView
    override func viewDidLoad() {
        super.viewDidLoad()
        SSTProgressHUD.show()
        appointmentData.delegate = self
        appointmentData.fetchData()
        self.tableView.reloadData()
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.rec_seq = 0
//            self.typeShow = 1
            
            switch self.typeShow {
            case 1:
               self.appointmentData.fetchData()
            case 2:
                self.appointmentData.getMyAppointment()
            case 3:
                self.appointmentData.searchAppointment(searchKey: self.searchKey, sex: validString(self.sex), province: self.province, city: self.city)
            default:
                print("--")
            }

            
            
        })
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.rec_seq = self.rec_seq + 1
            self.appointmentData.uploadRefresh(rec_seq: self.rec_seq)
            
        })

        emptyView.isHidden = true
        emptyView.frame = self.view.frame
        emptyView.setData(imgName: "icon_load", msg: "数据为空", buttonTitle: "刷新", buttonVisible: false)
        emptyView.buttonClick = {
            self.appointmentData.fetchData()
        }
        self.tableView.addSubview(emptyView)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.title =  "约会"
    }


    @IBAction func choseEvent(_ sender: Any) {
        
        eventView.isHidden = !eventView.isHidden
        switch typeShow {
        case 1:
            all.isHidden = false
            my.isHidden = true
            search.isHidden = true
        case 2:
            all.isHidden = true
            my.isHidden = false
            search.isHidden = true
        case 3:
            all.isHidden = true
            my.isHidden = true
            search.isHidden = false
        default:
            print("--")
        }
    }
    
    @IBAction func sendAppointment(_ sender: Any) {
        typeShow = 0
        eventView.isHidden = !eventView.isHidden
        performSegueWithIdentifier(.SegueToSendAppointmentVC, sender: nil)
    }
    
    @IBAction func allAppointment(_ sender: Any) {
        typeShow = 1
        eventView.isHidden = !eventView.isHidden
        SSTProgressHUD.show()
        appointmentData.fetchData()
    }
    @IBAction func myAppointment(_ sender: Any) {
        typeShow = 2
        eventView.isHidden = !eventView.isHidden
        SSTProgressHUD.show()
        appointmentData.getMyAppointment()
    }
    
    @IBAction func searchAppointment(_ sender: Any) {
        typeShow = 3
        eventView.isHidden = !eventView.isHidden

        performSegueWithIdentifier(.SegueToChoseAppointmentInfoVC, sender: nil)
        
    }
    

}

extension DATAppointmentVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointmentData.appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "\(DATAppointmentCell.classForCoder())") as? DATAppointmentCell
       
        if cell == nil {
            cell = loadNib(kDATAppointmentcell) as? DATAppointmentCell
        }
        cell?.userDetailBlack = {(appointment) in
            self.clickUser = appointment
            self.performSegueWithIdentifier(.SegueToUserDetailVC, sender: nil)
        }
        cell?.hiddlenZanView = {
            let cells = tableView.visibleCells
            for cell in cells {
                let ce = cell as? DATAppointmentCell
                ce?.eventView.isHidden = true
            }
        }
        cell?.appointment = self.appointmentData.appointments[indexPath.row]
        cell?.datingOrApply = {(type) in
            switch type {
            case .zan:
                DATAppointment().datingUp(dating_id: validInt(cell?.appointment?.datingId), { (data, error) in
                    SSTProgressHUD.dismiss()
                    if error == nil {
                        SSTToastView.showSucceed("点赞成功")
//                        SSTProgressHUD.showSuccessWithStatus("点赞成功")
                        self.appointmentData.fetchData()
                    }else {
                        SSTToastView.showSucceed("点赞成功")

                    }
                })
            case .fuyue:
                
                if cell?.appointment?.type == 1 {
                    if biz.user?.is_chat == 1 {
                        DATAppointment().datingApply(dating_id: validInt(cell?.appointment?.datingId), { (data, error) in
                            SSTProgressHUD.dismiss()
                            if error == nil {
                                SSTToastView.showSucceed("申请参加成功")
                                self.appointmentData.fetchData()
                            }else {
                                SSTToastView.showError(validString(validDictionary(error)["message"]))
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
                    DATAppointment().datingApply(dating_id: validInt(cell?.appointment?.datingId), { (data, error) in
                        SSTProgressHUD.dismiss()
                        if error == nil {
                            SSTToastView.showSucceed("申请参加成功")
                            self.appointmentData.fetchData()
                        }else {
                            SSTToastView.showError(validString(validDictionary(error)["message"]))
                        }
                    })
                }

                
               
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cells = tableView.visibleCells
        for cell in cells {
            let ce = cell as? DATAppointmentCell
            ce?.eventView.isHidden = true
        }
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as? DATAppointmentCell
        cell?.eventView.isHidden = true
        
        eventView.isHidden = true
        appointmentNow = self.appointmentData.appointments[indexPath.row]
        performSegueWithIdentifier(.SegueToAppointmentDetailVC, sender: nil)
    }
}


// MARK: -- segue delegate
extension DATAppointmentVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToAppointmentDetailVC         = "toAppointmentDetailVC"
        case SegueToSendAppointmentVC         = "toSendAppointmentVC"
        case SegueToPayVC         = "toPayVC"
        case SegueToChoseAppointmentInfoVC = "toChoseAppointmentInfoVC"
        case SegueToUserDetailVC = "toUserDetailVC"
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        switch segueIdentifierForSegue(segue) {
        case .SegueToAppointmentDetailVC:
            let destVC = segue.destination as! DATAppointmentDetailVC
            destVC.appointment = appointmentNow
            destVC.reflushAppointmentBlock = {
                switch self.typeShow {
                case 1:
                    self.appointmentData.fetchData()
                case 2:
                     self.appointmentData.getMyAppointment()
                default:
                    print("--")
                }
                
            }
        case .SegueToSendAppointmentVC:
            let destVC = segue.destination as! DATSendAppointmentVC
            destVC.type = .send
            destVC.reflushAppointmentBlock = {
                switch self.typeShow {
                case 1:
                    self.appointmentData.fetchData()
                case 2:
                    self.appointmentData.getMyAppointment()
                default:
                    print("--")
                }
            }
        case .SegueToPayVC:
            print("--")
        case .SegueToUserDetailVC:
            let destVC = segue.destination as! DATUserDetailVC
            destVC.user = clickUser
        case .SegueToChoseAppointmentInfoVC:
            let destVC = segue.destination as! DATChoseAppointmentInfoVC
            destVC.chooseInfoBlock = { keyWorld,sex, province,city in
                print("keyworldTextField.text==\(validString(keyWorld))")
                print("sex==\(sex)")
                print("province==\(province)")
                print("city==\(city)")
                self.searchKey = keyWorld
                self.sex = sex
                self.province = province
                self.city = city
                self.appointmentData.searchAppointment(searchKey: keyWorld, sex: validString(sex), province: province, city: city)
                
            }
            
        }
    }
    
}

// MARK: - SSTUIRefreshDelegate

extension DATAppointmentVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        if let tmpData = data as? DATAppointmentData {
            self.appointmentData = tmpData
            self.emptyView.isHidden = self.appointmentData.appointments.count > 0
        }
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
        self.tableView.reloadData()
    }
}
