//
//  DATLovepreferenceVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/4/6.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
// 恋爱便好
class DATLovepreferenceVC: DATBaseTVC {
    
    var indexPathNow = IndexPath()
    
    let user = biz.user
    
    @IBOutlet weak var datingTargetText: UITextField! //恋爱目的
    @IBOutlet weak var datingAdvantageText: UITextField! // 恋爱专长
    @IBOutlet weak var loveAttitudeText: UITextField! // 爱情观
    @IBOutlet weak var marriageAttitudeText: UITextField! // 婚姻观
    @IBOutlet weak var accLngDistanceText: UITextField! //是否接受异地恋
    @IBOutlet weak var doloveText: UITextField! // 是否接受婚前性行为
    
    
    @IBAction func saveAction(_ sender: Any) {
        if user != nil {
            SSTProgressHUD.show()
            user?.updateUserLovePrf(userTmp: user!)
        }
    }
    
    override func viewDidLoad() {
        self.tableView.tableFooterView = UIView()
        user?.delegate = self
        super.viewDidLoad()
        self.setData()

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        indexPathNow = indexPath
        performSegueWithIdentifier(.SegueToTableView, sender: nil)
    }
    
    func setData(){
        datingTargetText.text = user?.dating_target
        datingAdvantageText.text = user?.dating_advantage
        loveAttitudeText.text = user?.dating_attitude
        marriageAttitudeText.text = user?.marriage_attitude
        accLngDistanceText.text = user?.acc_lng_distance
        doloveText.text = user?.acc_sex_bef_marriage
    }
}

// MARK: -- segue delegate
extension DATLovepreferenceVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case SegueToTableView         = "toTableView"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToTableView:
            if indexPathNow.row == 0 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .makeingFriends
                destVC.chooseInfoBlock = { [unowned self] (info) in
                   self.user?.dating_target = validString(info)
                   self.datingTargetText.text = validString(info)
                }
            }
            if indexPathNow.row == 1 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .loveStrong
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.user?.dating_advantage = validString(info)
                    self.datingAdvantageText.text = validString(info)
                }
            }
            if indexPathNow.row == 2 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .loveLook
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.user?.dating_attitude = validString(info)
                    self.loveAttitudeText.text = validString(info)
                }
            }
            if indexPathNow.row == 3 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .marriageLook
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.user?.marriage_attitude = validString(info)
                    self.marriageAttitudeText.text = validString(info)
                }
            }
            if indexPathNow.row == 4 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .isCanDistantlove
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.user?.acc_lng_distance = validString(info)
                    self.accLngDistanceText.text = validString(info)
                }
            }
            if indexPathNow.row == 5 {
                let destVC = segue.destination as! DATEditInfoTableVC
                destVC.editType = .isCandoLovebeforeMarriage
                destVC.chooseInfoBlock = { [unowned self] (info) in
                    self.user?.acc_sex_bef_marriage = validString(info)
                    self.doloveText.text = validString(info)
                }
            }
        }
    }
}

// MARK: - SSTUIRefreshDelegate

extension DATLovepreferenceVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        self.tableView.reloadData()
    }
}
