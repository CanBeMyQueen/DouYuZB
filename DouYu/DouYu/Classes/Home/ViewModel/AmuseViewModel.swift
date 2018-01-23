//
//  AmuseViewModel.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/22.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var amuseGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}

extension AmuseViewModel {
    func getAmuseData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: "v1/getHotRoom/2", parameters: nil) { (result) in

            guard result is [String : Any] else { return }
            guard let dataArray = result["data"] as? [[String : Any]] else { return }
            for dict in dataArray {
                self.amuseGroups.append(AnchorGroupModel(dict: dict as! [String : NSObject]))
            }
            finishCallback()
        }
    }
}
