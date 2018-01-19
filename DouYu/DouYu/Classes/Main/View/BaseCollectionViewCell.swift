//
//  BaseCollectionViewCell.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/16.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    /// 属性设置
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var onlineNumberBtn: UIButton!

    var anchorRoom : AnchorRoomModel? {
        didSet {
            self.nickNameLabel.text = anchorRoom?.nickname
            self.roomNameLabel.text = anchorRoom?.room_name
            guard let online = anchorRoom?.online else {return}
            if online >= 10000 {
                 self.onlineNumberBtn .setTitle("\(online/10000)万在线", for: .normal)
            } else {
                self.onlineNumberBtn .setTitle("\(online)在线", for: .normal)
            }
        }
    }
}
