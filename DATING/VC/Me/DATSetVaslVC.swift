
//
//  DATSetVaslVC.swift
//  DATING
//
//  Created by 天星 on 17/9/30.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit

class DATSetVaslVC: UIViewController {

    @IBOutlet weak var audioSwitch: UISwitch!
    @IBOutlet weak var videoSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        if biz.user?.is_rcv_audio == true {
            self.audioSwitch.setOn(true, animated: true)
        }else {
            self.audioSwitch.setOn(false, animated: true)
        }
        
        if biz.user?.is_rcv_video == true {
            self.videoSwitch.setOn(true, animated: true)
        }else {
            self.videoSwitch.setOn(false, animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func videoAction(_ sender: Any) {
        let swit = sender as! UISwitch
        let inbutton = swit.isOn
        if inbutton == true {
            
            biz.user?.videoDisturb(is_rcv_video: true, { (data, error) in
                
                biz.user?.is_rcv_video = true
            })
        }else {
            
            biz.user?.videoDisturb(is_rcv_video: false, { (data, error) in
               
                biz.user?.is_rcv_video = false
            })
        }
    }

    @IBAction func acdioAction(_ sender: Any) {
        let swit = sender as! UISwitch
        let inbutton = swit.isOn
        if inbutton == true {
            
            biz.user?.audioDisturb(is_rcv_video: true, { (data, error) in
               
                biz.user?.is_rcv_audio = true
            })
        }else {
            
            biz.user?.audioDisturb(is_rcv_video: false, { (data, error) in
               
                biz.user?.is_rcv_audio = false
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
