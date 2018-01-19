//
//  RecommondViewModel.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/13.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class RecommondViewModel {
    // 懒加载存放所有模块的数组
    lazy var ancharGroups : [AnchorGroupModel] = [AnchorGroupModel]()
    lazy var bigDataAnchors : AnchorGroupModel = AnchorGroupModel()
    lazy var pettyAnchors : AnchorGroupModel = AnchorGroupModel()
    lazy var CycleModels : [CycleModel] = [CycleModel]()
}

extension RecommondViewModel {
    func requestData(callback: @escaping () -> ()) {
        // 定义参数
        let paratmers = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        // 创建一个组
        let disGroup = DispatchGroup()

        // 1.请求第一部分推荐数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1.将result 转换成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}

            // 2.根据 data的key， 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}

            // 3.遍历数组，获取字典，并且将字典转换成模型
            // 3.1设置组属性
            self.bigDataAnchors.tag_name = "热门"
            self.bigDataAnchors.icon_url = "home_header_hot"
            // 3.2获取主播数据
            for dict in dataArray {
                let anchorRoom = AnchorRoomModel(dict: dict)
                self.bigDataAnchors.anchorRooms.append(anchorRoom)
            }
            disGroup.leave()
            print("0数据请求完成")
        }

        // 2.请求第二部分颜值数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "v1/getVerticalRoom", parameters: paratmers) { (result) in
            // 1.将result 转换成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}

            // 2.根据 data的key， 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}

            // 3.遍历数组，获取字典，并且将字典转换成模型
            // 3.1设置组属性
            self.pettyAnchors.tag_name = "颜值"
            self.pettyAnchors.icon_url = "home_header_phone"
            // 3.2获取主播数据
            for dict in dataArray {
                let anchorRoom = AnchorRoomModel(dict: dict)
                self.pettyAnchors.anchorRooms.append(anchorRoom)
            }
            disGroup.leave()
            print("1数据请求完成")
        }

        // 3.请求后面部分游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1507961541
//         print(NSDate.getCurrentTime())
        disGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "v1/getHotCate", parameters: paratmers) { (result) in

            // 1.将result 转换成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}

            // 2.根据 data的key， 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}

            // 3.遍历数组，获取字典，并且将字典转换成模型
            for dict in dataArray {
                let group = AnchorGroupModel(dict: dict)
                self.ancharGroups.append(group)
            }
            disGroup.leave()
            print("2-12数据请求完成")
        }
        /// 4.将所有的数据请求完成
        disGroup.notify(queue: DispatchQueue.main) {
            print("所有数据请求完成")
            self.ancharGroups.insert(self.pettyAnchors, at: 0)
            self.ancharGroups.insert(self.bigDataAnchors, at: 0)
            callback()
        }
    }

    func requestCycleData(callback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: "v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray {
                self.CycleModels.append(CycleModel(dict: dict))
            }
            callback()

        }
    }

}
