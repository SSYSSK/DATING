//
//  TimeUtil.swift
//  DATING
//
//  Created by 天星 on 17/7/26.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//


import UIKit

let kEveryOneInTenSecondNotification = NSNotification.Name(rawValue: "EveryOneInTenSecond")
let kEveryOneSecondNotification = NSNotification.Name(rawValue: "EveryOneSecond")

final class TimeUtil: NSObject {
    
    static var shared: TimeUtil {
        struct Static {
            static let instance: TimeUtil = TimeUtil()
        }
        return Static.instance
    }
    
    var alarmCnt = 0
    
    private override init() {
        super.init()
        
        let timer = Timer(timeInterval: 60, target: self, selector: #selector(didTimerAlarm), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func didTimerAlarm() {
        print("过了一分钟")
    }
}
