//
//  CycleModel.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/23.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var id : Int = 0
    var title : String = ""
    var pic_url : String = ""
    var tv_pic_url : String = ""
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorRoomModel(dict: room)
        }
    }
    var anchor : AnchorRoomModel?

    /// MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
