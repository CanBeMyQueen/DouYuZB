//
//  FunnyViewModel.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/25.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseAnchorViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishCallback : @escaping () -> ()) {
        loadData(isGroupData: false, urlString: "v1/getColumnRoom/3", parameters: ["limit" : "30", "offset" : "0"], finishCallback: finishCallback)
    }
}
