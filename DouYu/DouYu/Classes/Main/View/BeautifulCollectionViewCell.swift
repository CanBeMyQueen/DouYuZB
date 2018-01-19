//
//  BeautifulCollectionViewCell.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/18.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit
import Kingfisher
class BeautifulCollectionViewCell: BaseCollectionViewCell {

    /// 设置属性
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var cityNameBtn: UIButton!
    override var anchorRoom : AnchorRoomModel? {
        didSet {
            guard let anchorRoom = anchorRoom else {return}
            super.anchorRoom = anchorRoom
            self.cityNameBtn.setTitle(anchorRoom.anchor_city, for: .normal)
            self.roomImageView.kf.setImage(with: URL.init(string: anchorRoom.vertical_src))
        }
    }

}
