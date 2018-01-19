//
//  NormalCollectionViewCell.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/18.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class NormalCollectionViewCell: BaseCollectionViewCell {

    /// 属性设置
    @IBOutlet weak var roomImageView: UIImageView!

    override var anchorRoom : AnchorRoomModel? {
        didSet {
            guard let anchor = anchorRoom else {return}
            super.anchorRoom = anchorRoom
            self.roomImageView.kf.setImage(with: URL.init(string: anchor.room_src))
        }
    }
}
