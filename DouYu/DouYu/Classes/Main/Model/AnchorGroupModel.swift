//
//  AnchorGroupModel.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/14.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class AnchorGroupModel: NSObject {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        // 属性监听器，监听数据改变，如果 room_list 赋值，将赋值的字典转成模型
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchorRooms.append(AnchorRoomModel(dict: dict))
            }
        }
    }
    /// 组标题
    var tag_name : String = ""
    /// 组显示的图标
    var icon_url : String = ""

    var small_icon_url : String = ""
    // 懒加载主播房间模型对象数组
    lazy var anchorRooms : [AnchorRoomModel] = [AnchorRoomModel]()
    override init() {
        
    }
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    /*
    // 重写 setValueForKey 方法，判断房间列表 key, 将房间列表字典数据转换成 model数据
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchorRooms.append(AnchorRoomModel(dict: dict))
                }
            }
        }
    }
 */
}
