//
//  CollectionViewGameCell.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/25.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var gameNameLabel: UILabel!
    var group : BaseGameModel? {
        didSet {
            self.gameNameLabel.text = group?.tag_name
            self.gameImageView.kf.setImage(with: URL.init(string: (group?.icon_url)!))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        gameImageView.layer.cornerRadius = 25
        gameImageView.layer.masksToBounds = true
    }

}
