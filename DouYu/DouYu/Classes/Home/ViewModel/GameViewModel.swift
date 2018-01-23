//
//  GameViewModel.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/22.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class GameViewModel : BaseGameModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: "v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            for dict in dataArray {
                self.games.append(GameModel(dict: dict as! [String : NSObject] ))
            }

            finishCallback()

         }
    }
}
