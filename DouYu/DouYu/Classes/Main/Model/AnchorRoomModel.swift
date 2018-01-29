//
//  AnchorRoomModel.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/14.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class AnchorRoomModel: NSObject {
    var specific_catalog : String = ""
    var vertical_src : String = ""
    var owner_uid : Int = 0
//    var ranktype : String = ""
    var nickname : String = ""      /// 主播昵称
    var room_src : String = ""
    var cate_id : Int = 0
    var specific_status : Int = 0
    var game_name : String = ""
    var avatar_small : String = ""
    var online : Int = 0    /// 在线人数
    var avatar_mid : String = ""
    var room_name : String = ""     /// 房间名字
    var room_id : String = ""       /// 房间 ID
    var show_time : Int = 0
    var isVertical : Int = 0        /// 设备标识 1：手机， 0: 电脑
    var show_status : Int = 0
    var jumpUrl : String = ""
    var rmf1 : Int = 0
    var rmf2 : Int = 0
    var anchor_city : String = ""   /// 所在城市

    init(dict : [String : Any]) {
        super.init();
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "online" {
//            let name = String.init(describing: value);
//            print(name)
//
//        }
//    }

}
