//
//  NSDate-Extension.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/14.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970;
        return "\(interval)"
    }
}
