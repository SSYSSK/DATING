//
//  Utils.swift
//  sst-ios-po
//
//  Created by Zal Zhang on 12/26/16.
//  Copyright © 2016 po. All rights reserved.
//

import UIKit
import AlamofireImage

func presentLoginVC(loginType : LoginType = .login ,callback: @escaping RequestCallBack) {
    
    let loginNC = loadVC(controllerName: "SSTLoginNC", storyboardName: "Login") as! SSTBaseNC
    let vc = loginNC.viewControllers.first
    if let v = vc as? SSTLoginVC {
        let new = v as SSTLoginVC
        new.logintype = loginType
    }
    
    print("loginNC.childViewControllers===\(loginNC.childViewControllers)")
    let window = UIApplication.shared.delegate?.window
    if window != nil {
        window!!.rootViewController?.present(loginNC, animated: true, completion: nil)
    }
}

func iime() -> Bool {

    if(Date().formatyyMMdd().contains("2018")){

         return false
    }else{

        return true

    }

}

func loadNib(_ nibName: String) -> AnyObject? {
    return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as AnyObject?
}

func initNib(_ nibName: String) -> UINib {
    return UINib(nibName: "\(nibName)", bundle: nil)
}

func loadVC(controllerName: String, storyboardName: String) -> AnyObject {
    let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
    return storyboard.instantiateViewController(withIdentifier: controllerName)
}

func validBool(_ data: Any?) -> Bool {
    if data == nil {
        return false
    } else {
        return data as! Bool
    }
}

func validString(_ data: Any?) -> String {
    if data == nil {
        return ""
    } else {
        let tData = data! as AnyObject
        if tData.isKind(of: NSString.classForCoder()) {
            return tData as! String
        } else if tData.isKind(of: NSNumber.classForCoder()) {
            return tData.stringValue
        }
    }
    return ""
}

func validDouble(_ data: Any?) -> Double {
    if data == nil {
        return 0
    } else {
        let tData = data! as AnyObject
        if tData.isKind(of: NSNumber.classForCoder()) || tData.isKind(of: NSString.classForCoder()) {
            return tData.doubleValue
        }
    }
    return 0
}

func validInt(_ data: Any?) -> Int {
    if data == nil {
        return 0
    } else {
        let tData = data! as AnyObject
        if tData.isKind(of: NSNumber.classForCoder()) || tData.isKind(of: NSString.classForCoder()) {
            return tData.integerValue
        }
    }
    return 0
}

func validInt64(_ data: Any?) -> Int64 {
    if data == nil {
        return 0
    } else {
        let tData = data! as AnyObject
        if tData.isKind(of: NSNumber.classForCoder()) || tData.isKind(of: NSString.classForCoder()) {
            return tData.longLongValue
        }
    }
    return 0
}

func validNSDictionary(_ data: Any?) -> NSDictionary {
    if data == nil {
        return NSDictionary()
    }
    if (data! as AnyObject).isKind(of: NSDictionary.classForCoder()) {
        return data as! NSDictionary
    }
    return NSDictionary()
}

func validDictionary(_ data: Any?) -> Dictionary<String,AnyObject> {
    if data == nil {
        return Dictionary()
    }
    if (data! as AnyObject).isKind(of: NSDictionary.classForCoder()) {
        return data as! Dictionary
    }
    return Dictionary()
}

func validNSArray(_ data: Any?) -> NSArray {
    if data == nil {
        return NSArray()
    }
    if (data! as AnyObject).isKind(of: NSArray.classForCoder()) {
        return data as! NSArray
    }
    return NSArray()
}

func validArray(_ data: Any?) -> Array<AnyObject> {
    if let r = data as? Array<AnyObject> {
        return r
    }
    return Array()
}

func isError(_ data: Any?) -> Bool {
    if (data as AnyObject).isKind(of: NSError.classForCoder()) {
        return true
    } else if (data.unsafelyUnwrapped as? Error) != nil {
        return true
    }
    return false
}

extension Int64 {
    func format(f: Int! = 2) -> String {
        var r = String(self)
        let cnt = f - r.characters.count
        if cnt > 0 {
            var zeros = ""
            for _ in 0 ..< cnt {
                zeros = "0" + zeros
            }
            r = zeros + r
        }
        return r
    }
}

extension NSArray {
    func validObjectAtIndex(_ index: Int) -> AnyObject? {
        if index < self.count {
            return object(at: index) as AnyObject?
        } else {
            return nil
        }
    }
}

extension Array {
    func validObjectAtIndex(_ index: Int) -> AnyObject? {
        if index < self.count {
            return self[index] as AnyObject?
        } else {
            return nil
        }
    }
}

extension UIImageView {
    func setImage(fileUrl: String, placeholder: String? = nil) {
        var image: UIImage? = nil
        if placeholder != nil {
            image = UIImage(named: placeholder!)
        }
        if fileUrl.isEmpty {
            self.image = image
        } else {
            if var mURL = URL(string: fileUrl) {
                if validString(mURL.scheme) == "" {
                    if let tmpUrl = URL(string: kBaseImageURL + fileUrl) {
                        mURL = tmpUrl
                    }
                }
                self.af_setImage(withURL: mURL, placeholderImage: image)
            }
        }
    }
    func setImageWithImage(fileUrl: String, placeImage: UIImage? = nil) {
        
        if fileUrl.isEmpty {
            self.image = placeImage
        } else {
            if var mURL = URL(string: fileUrl) {
                if validString(mURL.scheme) == "" {
                    mURL = URL(string: kBaseImageURL + fileUrl)!
                }
                self.af_setImage(withURL: mURL, placeholderImage: placeImage)
            }
        }
    }

}

let kDateFormatFromString = "yyyy-MM-dd HH:mm:ss Z" // "EEE MMM dd HH:mm:ss zzz yyyy"
let kDateFormatToString = "MM/dd/yyyy HH:mm"
let kDateDDFormatToString = "yyyy-MM-dd"
let kDateFormatYYYYMM = "yyyy-MM"

extension UIImage
{
    func grayImage(image:UIImage)->UIImage {
        UIGraphicsBeginImageContext(self.size)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext(data: nil , width: Int(self.size.width), height: Int(self.size.height),bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)
        context?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let cgImage = context!.makeImage()
        let grayImage = UIImage.init(cgImage: cgImage!)
        return grayImage
    }
}

extension Date {
    static func formatTime(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormatFromString
        dateFormatter.timeZone = NSTimeZone(abbreviation:"CST") as TimeZone!
        let date = dateFormatter.date(from: dateString)
        return dateFormatter.string(from: date!)
    }
    static func fromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormatFromString
        return dateFormatter.date(from: dateString)
    }
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormatFromString
        return dateFormatter.string(from: self)
    }
    func formatYYYYMM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormatYYYYMM
        return dateFormatter.string(from: self)
    }
    func formatHMmmddyyyy() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormatToString
        return dateFormatter.string(from: self)

    }
    func formatyyMMdd() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateDDFormatToString
        return dateFormatter.string(from: self)
    }
    func getJsonObject(data: NSData) -> AnyObject? {
        return try! JSONSerialization.jsonObject(with: data as Data, options:JSONSerialization.ReadingOptions.allowFragments) as AnyObject?
    }
}

func getUserDefautsData(name: String) -> AnyObject? {
    return UserDefaults.standard.object(forKey: name) as AnyObject?
}

func printDebug(_ msg: String) {
    #if DEV
        print(msg)
    #endif
}

func showToastOnlyForDEV(_ msg: String, duration: Double = 3.5) {
    #if DEV
        ToastUtil.showToast(msg)
    #endif
}

//func presentLoginVC(_ callback: @escaping RequestCallBack) {
//    let loginNC = loadVC(controllerName: "SSTLoginNC", storyboardName: "Login") as! SSTBaseNC
//    let loginVC = loginNC.childViewControllers.first as! SSTLoginAndRegisterVC
//    loginVC.relogBlock = { isLogined in
//        if isLogined {
//            callback(nil, nil)
//        } else {
//            callback(nil, "User not login.")
//        }
//    }
//    let window = UIApplication.shared.delegate?.window
//    window!!.rootViewController?.present(loginNC, animated: true, completion: nil)
//}

var window: UIWindow {
    get {
        return (UIApplication.shared.delegate?.window)!!
    }
}

func getTopVC() -> UIViewController? {
    let window = UIApplication.shared.delegate?.window
    if let tabBarController = window!!.rootViewController as? UITabBarController {
        if let nc = tabBarController.selectedViewController as? UINavigationController {
            return nc.childViewControllers.last
        }
    }
    return nil
}

func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func isCanUseCamera() -> Bool {
//    let author = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
//    if (author == .restricted || author == .denied) {
//        return false
//    } else {
//        return true
//    }
    return true
}

// MARK: - 根据image计算放大之后的frame

func calculateFrameWithImage(image : UIImage) -> CGRect {
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height

    let w = screenW
    let h = screenW / image.size.width * image.size.height
    let x : CGFloat = 0
    let y : CGFloat = (screenH - h) * 0.5
    
    return CGRect(x: x, y: y, width: w, height: h)
}

