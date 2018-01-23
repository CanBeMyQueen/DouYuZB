//
//  BaseGameModel.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/22.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    /// 组标题
    var tag_name : String = ""
    /// 组显示的图标
    var icon_url : String = ""
    override init() {

    }
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
