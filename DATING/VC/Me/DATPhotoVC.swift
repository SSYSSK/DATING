//
//  DATPhotoVC.swift
//  DATING
//
//  Created by 天星 on 17/4/1.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
let kDATPhotoCell = "DATPhotoCell"
class DATPhotoVC: UIViewController {
    var images = [String]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = false
        
        return pickVC
    }()
    
    var album = DATUserAlbums()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        for index in 0 ..< validInt(biz.user?.userAlbums.count)  {
            images.append(validString(biz.user?.userAlbums[index].url))
        }
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let alertController = UIAlertController(title: "",
                                                message: "选择照片", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let nanAction = UIAlertAction(title: "从相册中上传", style: .default, handler: {
            action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.pickVC.sourceType = .photoLibrary
                
                self.present(self.pickVC, animated: true, completion: nil)
            } else {
                SSTProgressHUD.showErrorWithStatus("不能打开照相机")
                
            }
        })
        
        let nvAction = UIAlertAction(title: "拍照上传", style: .default, handler: {
            action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.pickVC.sourceType = .camera
                
                self.present(self.pickVC, animated: true, completion: nil)
            } else {
                SSTProgressHUD.showErrorWithStatus("不能打开照相机")
                
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(nanAction)
        alertController.addAction(nvAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
}
//MARK:-- imagePicker delegate
extension DATPhotoVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerControllerMediaType] as? String) != nil {
            SSTProgressHUD.show()
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let new = image.resizeImage(originalImg: image)
            print("new===\(new)")
            biz.uploadImage(image: new, fileType: "album", { (data, error) in
                print("data==\(data)")
                SSTProgressHUD.dismiss()
                let userDict = validNSDictionary(validNSDictionary(data)["file"])
                self.album = DATUserAlbums().update(userDict)
                
                biz.user?.userAlbums.append(self.album)
                self.collectionView.reloadData()
            })
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


extension DATPhotoVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return validInt(biz.user?.userAlbums.count)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDATPhotoCell, for: indexPath) as! DATPhotoCell
        let userAlbums = biz.user?.userAlbums[indexPath.row]
        cell.userAlbums = userAlbums
        cell.deleteImageBlock = { album in
            print(validString(album?.file_id))
            print(validString(album?.url))
            
            let alertController = UIAlertController(title: "",
                                                    message: "删除照片", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let nanAction = UIAlertAction(title: "删除", style: .default, handler: {
                action in
                biz.user?.userAlbums.remove(at: indexPath.row)
                self.collectionView.reloadData()
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(nanAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //图片索引
        let index = indexPath.row
        //进入图片全屏展示
        let previewVC = ImagePreviewVC(images: images, index: index)
        self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: DATPhotoCellWidth , height: DATPhotoCellWidth/120*126)
        
    }
    //设置每个item的UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5*kProkScreenWidth, left: 5*kProkScreenWidth, bottom: 0, right: 5*kProkScreenWidth)
    }
    
    //动态设置每行的间距大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10*kProkScreenWidth;
    }
    
    //动态设置每列的间距大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2*kProkScreenWidth;
    }

}

