//
//  BaseAnchorViewModel.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/23.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class BaseAnchorViewModel {
    // 懒加载存放所有模块的数组
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}

extension BaseAnchorViewModel {
    func loadData(isGroupData : Bool, urlString : String, parameters : [String : Any]? = nil, finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: urlString, parameters: parameters) { (result) in

            guard result is [String : Any] else { return }
            guard let dataArray = result["data"] as? [[String : Any]] else { return }
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroupModel(dict: dict as! [String : NSObject]))
                }
            } else {
                let group = AnchorGroupModel()
                for dict in dataArray {
                    group.anchorRooms.append(AnchorRoomModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }

            finishCallback()
        }
    }
}
