//
//  AmuseViewModel.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/22.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseAnchorViewModel {

}

extension AmuseViewModel {
    func getAmuseData(finishCallback : @escaping () -> ()) {
        self.loadData(isGroupData: true, urlString: "v1/getHotRoom/2", parameters: nil, finishCallback: finishCallback)
    }
}
