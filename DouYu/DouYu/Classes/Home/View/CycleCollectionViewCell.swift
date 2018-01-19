//
//  CycleCollectionViewCell.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/23.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit
import Kingfisher
class CycleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    var cycleModel : CycleModel? {
        didSet {
            roomNameLabel.text = cycleModel?.title
            self.roomImageView.kf.setImage(with: URL.init(string: (cycleModel?.pic_url)!))
        }
    }

}
