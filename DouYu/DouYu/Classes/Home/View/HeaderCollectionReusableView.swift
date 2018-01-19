//
//  HeaderCollectionReusableView.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/18.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit
import Kingfisher
class HeaderCollectionReusableView: UICollectionReusableView {

    /// 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    /// 定义模型属性
    var group : AnchorGroupModel? {
        didSet {
            titleLabel.text = group?.tag_name
            if (group?.icon_url == nil || group?.icon_url == "") {
                group?.icon_url = "home_header_normal"
            }
            iconImageView.kf.setImage(with: URL.init(string: (group?.small_icon_url)!))
        }
    }

}
