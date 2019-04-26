//
//  DATMeVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/3/30.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATMeVC: DATBaseTVC {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!

    @IBOutlet weak var moneyLabel: UILabel!
    let user = DATUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(DATMeVC.iconEvent))
        iconImageView.addGestureRecognizer(tap)
        
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let user = DATUser()
        user.delegate = self
        user.token_code = validString(getUserDefautsData(kToken_code))
        user.login_name = validString(getUserDefautsData(kLogin_name))
        user.login_plain_pwd = validString(getUserDefautsData(kLogin_plain_pwd))
        user.phone = validString(getUserDefautsData(kPhone))
        user.getMyUserDetail(userTmp: user)
        
        
    }
    
    func iconEvent() {
        
        let alertVC = UIAlertController(title: "", message: "选择打开方式", preferredStyle: UIAlertControllerStyle.actionSheet)
        let acSure = UIAlertAction(title: "打开相册", style: UIAlertActionStyle.destructive) { (UIAlertAction) -> Void in
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)

        }
        let acSure1 = UIAlertAction(title: "拍照", style: UIAlertActionStyle.destructive) { (UIAlertAction) -> Void in
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
        }
        
        alertVC.addAction(acSure)
        alertVC.addAction(acSure1)
        alertVC.addAction(acCancel)
        self.present(alertVC, animated: true, completion: nil)
        
        
    }
    
    func setData(){
        iconImageView.setImage(fileUrl:validString(biz.user?.main_picts_url_thum), placeholder: kIcon_loading)
        nameLabel.text = biz.user?.nickname // (biz.user?.nickname == nil ? biz.user?.nickname:biz.user?.user_id)
        messageLabel.text = "\(validString(biz.user?.age))岁/\(validString(biz.user?.height))cm/\(validString(biz.user?.diploma))"
        IDLabel.text = "约会ID:\(validString(biz.user?.login_name))"
        moneyLabel.text = "金币:\(validString(biz.user?.money))"
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
        if indexPath.section == 0 && indexPath.row == 0 {
            iconEvent()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            performSegueWithIdentifier(.SegueToPhotoVC, sender: nil)
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            performSegueWithIdentifier(.SegueToMyInfoVC, sender: nil)
        }
        if indexPath.section == 1 && indexPath.row == 2 {
            performSegueWithIdentifier(.SegueToLovepreferenceVC, sender: nil)
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            performSegueWithIdentifier(.SegueToProposalVC, sender: nil)
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            performSegueWithIdentifier(.SegueToPayVC, sender: nil)
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            performSegueWithIdentifier(.SegueToGiftVC, sender: nil)
        }
        if indexPath.section == 3 && indexPath.row == 1 {
            performSegueWithIdentifier(.SegueToSettingVC, sender: nil)
        }
    }

}
//MARK:-- imagePicker delegate
extension DATMeVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                let clipView = YSHYClipViewController(image: image)
                clipView?.delegate = self
                picker.pushViewController(clipView!, animated: true)
            }
        } else {

             SSTProgressHUD.showErrorWithStatus("打开相册失败")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK:-- imagePicker delegate
extension DATMeVC: ClipViewControllerDelegate {
    func clipViewController(_ clipViewController: YSHYClipViewController!, finishClipImage editImage: UIImage!) {
        clipViewController.dismiss(animated: true) { 
            self.iconImageView.image = editImage
            
            // upload image
            biz.user?.uploadImage(image: editImage, fileType: UploadImageType.icon.rawValue, { (data, error) in
                debugPrint("data====\(data)")
                debugPrint("error====\(error)")
            })
        }
    }
}

// MARK: -- segue delegate
extension DATMeVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case SegueToPhotoVC         = "toPhotoVC"
        case SegueToMyInfoVC         = "toMyInfoVC"
        case SegueToLovepreferenceVC         = "toLovepreference"
        case SegueToProposalVC         = "toProposal"
        case SegueToPayVC         = "toPay"
        case SegueToGiftVC         = "toGiftVC"
        case SegueToSettingVC         = "toSetting"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToPhotoVC:
            debugPrint("-----")
        case .SegueToMyInfoVC:
            debugPrint("-----")
        case .SegueToLovepreferenceVC:
            debugPrint("-----")
        case .SegueToProposalVC:
            debugPrint("-----")
        case .SegueToPayVC:
            debugPrint("-----")
        case .SegueToSettingVC:
            debugPrint("-----")
        case .SegueToGiftVC:
            debugPrint("-----")

        }
    }
}

// MARK: - SSTUIRefreshDelegate

extension DATMeVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        biz.user = data as? DATUser
        setData()
    }
}
