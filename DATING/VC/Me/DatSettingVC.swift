//
//  DatSettingVC.swift
//  DATING
//
//  Created by 天星 on 17/5/12.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DatSettingVC: DATBaseTVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }else {
            return 7
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            performSegueWithIdentifier(.SegueToResetPasswordVC, sender: nil)
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            performSegueWithIdentifier(.SegueToDATSetVaslVC, sender: nil)
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            
            SSTProgressHUD.showInfoWithStatus("当前已经是最新版本")
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            performSegueWithIdentifier(.SegueToIntroductionVC, sender: nil)
        }
        if indexPath.section == 2 && indexPath.row == 2 {
            performSegueWithIdentifier(.SegueToServiceVC, sender: nil)
        }
        if indexPath.section == 2 && indexPath.row == 3 {
            
            setUserDefautsData(kToken_code, value: "")
            setUserDefautsData(kLogin_name, value: "")
            setUserDefautsData(kLogin_plain_pwd, value: "")
            FileOP.archive(kUserFileName, object: "")
            
            let alertVC = UIAlertController(title: "", message: "选择操作方式", preferredStyle: UIAlertControllerStyle.actionSheet)
            let acSure = UIAlertAction(title: "退出账号", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                if validInt(biz.cheatData?.friends.count) > 0 {
                    for user in (biz.cheatData?.friends)!{
                        // 发送退出登录消息
                        let seccsion = NIMSession(validString(user.login_name), type: NIMSessionType.P2P)
                        let message = NIMMessage()
                        message.from = validString(biz.user?.login_name)
                        message.text = "\(validString(biz.user?.nickname))已下线"
                        try? NIMSDK.shared().chatManager.send(message, to: seccsion)
                    }
                }
                presentLoginVC(loginType: LoginType.loginAgain, callback: { (data, error) in
                    
                })
            }
            let acSure1 = UIAlertAction(title: "切换账号", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                presentLoginVC(loginType: LoginType.login, callback: { (data, error) in
                    
                    
                })
            }
            let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
            }
            
            alertVC.addAction(acSure)
            alertVC.addAction(acSure1)
            alertVC.addAction(acCancel)
            self.present(alertVC, animated: true, completion: nil)
            
        }
    }

}
// MARK: -- segue delegate
extension DatSettingVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToDATSetVaslVC         = "toDATSetVaslVC"
        case SegueToResetPasswordVC         = "toResetPassword"
        case SegueToIntroductionVC         = "toIntroduction"
        case SegueToServiceVC         = "toService"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

