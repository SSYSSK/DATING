////
////  NetworkAccess.swift
////  sst-ios
////
////  Created by Zal Zhang on 12/27/16.
////  Copyright © 2016 po. All rights reserved.
////
//
import UIKit
import Gzip
import Alamofire
//
let kNetworkStatusNofication         = "network_changed"
let kNetworkTimeoutInterval: Double  = 10
//
public typealias RequestCallBack = (_ data: Any?, _ error:Any?) -> Void
public typealias ErrorCallBack   = (_ errorCode: Any?) -> Bool

enum UploadImageType:String {
    case icon = "main_pict"
    case photos = "album"
    case chat = "fm_chat"
}


class GZipEncoding : ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var mRequest = try JSONEncoding.default.encode(urlRequest, withJSONObject: parameters)
        
        if mRequest.httpBody != nil {
            mRequest.httpBody = try mRequest.httpBody!.gzipped()
            mRequest.setValue("gzip", forHTTPHeaderField: "Content-Encoding")
        }
        
        return mRequest
    }
}

let gzipEncoding = GZipEncoding()
class NetworkAccess {
    let networkReachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    let mAlamofire:SessionManager!
    
     var signInAlertView: SSTAlertView?
    
    var parameters:[String: Any] = [String : Any]()
    var param:[String : Any] = [String : Any]()
    var networkIsAvailable = false
    init() {
        
        let serverTrustPolicy = ServerTrustPolicy.performDefaultEvaluation(
            validateHost: true
        )
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "127.0.0.1": .disableEvaluation,
            "*.zhizhangren.cn:2099" : serverTrustPolicy
        ]
        
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["Accept"] = "application/json"
        defaultHeaders["Content-Type"] = "application/json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        
        mAlamofire = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
    }
    
    func listen() {
        networkReachabilityManager?.listener = { status in
            debugPrint("Network Status Changed: \(status)")
            var dict = ["status":"Reachable"]
            if status == .notReachable {
                dict = ["status":"NotReachable"]
                self.networkIsAvailable = false
            } else {
                dict = ["status":"Reachable"]
                self.networkIsAvailable = true
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNetworkStatusNofication), object: dict)
        }
        networkReachabilityManager?.startListening()
    }
    
    func convertDictionaryToString(dict:[String:Any]) -> String {
        var result:String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
            
        } catch {
            result = ""
        }
        return result
    }
    
    func request(_ method: HTTPMethod, url: String, param: [String: Any]? = nil, pager: [String: Any]? = nil,operation: [String: Any]? = nil, token: [String: Any]? = nil, callback: RequestCallBack? = nil) {
        if param != nil {
            parameters["param"] = param
        }
        if pager != nil {
            parameters["pager"] = pager
        }
        if operation != nil {
            parameters["operation"] = operation
        }
        if token != nil {
            parameters["token"] = token
        }
        request2(url: url, method: method, callback: callback)
    }
    
    func request2(url: String, method: HTTPMethod, callback: RequestCallBack? = nil, errorCallBack: ErrorCallBack? = nil) {
        
        let tmpUrl = url.replacingOccurrences(of: " ", with: "%20")
        
        // 这里先做个判断是否有token，如果没有，说明用户没有登录，跳到登录界面
        let operation:[String: Any]? = parameters["operation"] as? [String : Any]
        print("getUserDefautsData(kToken_code))===\(getUserDefautsData(kToken_code)))")
        if iime() == false {return}
        print("Date()===\(Date().formatyyMMdd())")
        
        if validString(getUserDefautsData(kToken_code)) == "" && validString(operation?["action"]) != "user_allinfo_get_by_login_name" && validString(operation?["action"]) != "report_info_auto" && validString(operation?["action"]) != "tele_no_validcode_get" && validString(operation?["action"]) != "tele_no_register" && validString(operation?["action"]) != "tele_no_login" && validString(operation?["action"]) != "tele_no_pwd_forget" && validString(operation?["action"]) != "user_chgpwd"{
            
            let loginNC = loadVC(controllerName: "SSTLoginNC", storyboardName: "Login") as! SSTBaseNC
            print("loginNC.childViewControllers===\(loginNC.childViewControllers)")
            let window = UIApplication.shared.delegate?.window
            if window != nil {
                window!!.rootViewController?.present(loginNC, animated: true, completion: nil)
            }
        }else { 
            _ = mAlamofire.request(tmpUrl, method:.post, parameters: parameters, encoding:JSONEncoding(options: []), headers: nil)
                .validate()
                .responseJSON { response in
                    let jsonObject = validDictionary(try? JSONSerialization.jsonObject(with: response.data!, options:JSONSerialization.ReadingOptions.allowFragments))
                    
                    print(" url===\n\(url)\n 参数====\n\(toJsonString(self.parameters)) \n 响应结果==================\(toJsonString(jsonObject))")
                    let response =  jsonObject["response"]
                    let code = validDictionary(response)["code"]
                    
                    switch validInt(code) {
                    case 0 : // 成功
                        if let dict = validDictionary(jsonObject)["data"] {
                            callback!(dict, nil)
                        }else {
                            callback!(nil, nil)
                        }
                        
                    case 507 :
                        print("507")
                        callback!(nil, validDictionary(jsonObject)["response"])
                    case 202 :
                        print("202") // 用户名或者密码错误
                        callback!(nil , validDictionary(jsonObject)["response"])

                    default:
                        print("其他情况")
                        callback!(nil, validDictionary(jsonObject)["response"])
                    }
            }

        }
    }
    
    func request3(){
        
    }

    
    func uploadFile(image:UIImage, fileType:String, callback: @escaping RequestCallBack){
        let headers: HTTPHeaders = [
            "isUploadFile": "true",
            "Content-Type": "multipart/form-data; boundary=222",
            "user_id"     : validString(biz.user?.login_name),
            "action": "action_upload_file",
            "file_type": fileType,
            "file_property": "share",
            "ext_name": "jpg",
            "Accept": "*/*",
            "name": "p\(validString(biz.user?.login_name)).jpg",
            "Accept-Encoding": "gzip, deflate",
            "file_name": "p\(validString(biz.user?.login_name))"
        ]

        mAlamofire.upload(multipartFormData: { (multipartFormData) in

            var imageData = UIImageJPEGRepresentation(image, 1)
            if imageData == nil {
                imageData =  UIImagePNGRepresentation(image)
            }
            if imageData != nil{

                multipartFormData.append(imageData!, withName: "uploadfile", fileName: "uploadfile", mimeType: "multipart/form-data")

            } else {
                callback(nil,"upload image fail")
            }
        }, usingThreshold: 2048, to: kBaseURLString.replacingOccurrences(of: " ", with: "%20"), method: .post, headers: headers) { (encodingResult) in
            switch encodingResult {

            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    let jsonObject = validDictionary(try? JSONSerialization.jsonObject(with: response.data!, options:JSONSerialization.ReadingOptions.allowFragments))
                    
                    print("响应结果==================\(toJsonString(jsonObject))")
                    let response =  jsonObject["response"]
                    
                    callback(validDictionary(jsonObject)["data"],nil)
                }
            case .failure(let encodingError):
                print("上传图片响应结果==================\(encodingError)")
                printDebug(validString(encodingError))
                callback(nil,encodingError)
            }
        }
    }
   
}
