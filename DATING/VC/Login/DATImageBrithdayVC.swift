
//
//  DATImageBrithdayVC.swift
//  DATING
//
//  Created by 林丽萍 on 2017/6/19.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATImageBrithdayVC: DATBaseVC {
    
    var user = DATUser()
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var brithdayTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
   
    var hasChoseImage = false
    
    fileprivate lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = false
        
        return pickVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
       nickNameLabel.text = validString(user.nickname)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DATImageBrithdayVC.choseImage))
        iconImageView.isUserInteractionEnabled = true
        iconImageView.addGestureRecognizer(tap)
    }
    
    func choseImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickVC.sourceType = .photoLibrary
            
            self.present(pickVC, animated: true, completion: nil)
        } else {
            SSTProgressHUD.showErrorWithStatus("不能打开照相机")

        }
        
    }

    @IBAction func nextAction(_ sender: Any) {
        let alertController = UIAlertController(title: "提示",
                                                message: "你注册性别为\(validString(self.sexTextField.text)),确定后将不能修改", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let destructiveAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            self.performSegueWithIdentifier(.SegueToRegisResultVC, sender: nil)
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(destructiveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func choseBorithday(_ sender: Any) {
        let dateView = loadNib("ChoseBrithdayView") as!  ChoseBrithdayView
        dateView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        dateView.hiddlenActionBlock = { date in
            self.brithdayTextField.text = date
            self.user.birtyday = date
        }
        self.view.addSubview(dateView)
    }
    
    func showNextButton() {
       
        if validString(sexTextField.text) != "" && validString(brithdayTextField.text) != "" && hasChoseImage != false{
            nextButton.isEnabled = true
            nextButton.backgroundColor = RGBA(214, g: 62, b: 35, a: 1)
        }else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = RGBA(201, g: 201, b: 201, a: 1)
        }
    }
   
    @IBAction func choseSex(_ sender: Any) {
        let alertController = UIAlertController(title: "选择性别",
                                                message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let nanAction = UIAlertAction(title: "男", style: .default, handler: {
            action in
            self.sexTextField.text = "男"
            self.user.sex = 0
            self.showNextButton()
        })
        
        let nvAction = UIAlertAction(title: "女", style: .default, handler: {
            action in
            self.sexTextField.text = "女"
            self.user.sex = 1
            self.showNextButton()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(nanAction)
        alertController.addAction(nvAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

//MARK:-- imagePicker delegate
extension DATImageBrithdayVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                
                //压缩图片，然后上传
                let photoTweaksViewController = PhotoTweaksViewController(image: image)
                photoTweaksViewController?.delegate = self;
                photoTweaksViewController?.autoSaveToLibray = true;
                photoTweaksViewController?.maxRotationAngle = CGFloat(M_PI_4);
                picker.pushViewController(photoTweaksViewController!, animated: true)
                print("image==\(image)")
                
                
                hasChoseImage = true
                self.showNextButton()
            }
        } else {
            SSTToastView.showError(kOpenPhotoFailedText)
        }
        
    }
}
extension DATImageBrithdayVC: PhotoTweaksViewControllerDelegate  {
    func photoTweaksControllerDidCancel(_ controller: PhotoTweaksViewController!) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func photoTweaksController(_ controller: PhotoTweaksViewController!, didFinishWithCroppedImage croppedImage: UIImage!) {
//        iconImageView.image = croppedImage
//        
        // 压缩头像
        let new = croppedImage.resizeImage(originalImg: croppedImage)
        print("new===\(new)")
        iconImageView.image = new
        
        controller.dismiss(animated: true, completion: nil)
    }
}
// MARK: -- segue delegate
extension DATImageBrithdayVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToRegisResultVC        = "toRegisterInputPhone"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DATRegisterInputPhone
        destVC.user = self.user
        destVC.image = iconImageView.image!
    }
}
