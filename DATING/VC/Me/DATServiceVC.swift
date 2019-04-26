//
//  DATServiceVC.swift
//  DATING
//
//  Created by 天星 on 17/5/12.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATServiceVC: DATBaseVC {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        webView.isOpaque = false
        let filePath=Bundle.main.path(forResource: "service_declaration_zh-1", ofType: "html")
        do {
            let htmlString=try NSString.init(contentsOfFile: filePath!, encoding: String.Encoding.utf8.rawValue)
            webView.loadHTMLString(htmlString as String  , baseURL: NSURL.fileURL(withPath: filePath!))
        } catch {
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
