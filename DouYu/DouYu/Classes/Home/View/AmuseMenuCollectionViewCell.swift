//
//  AmuseMenuCollectionViewCell.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/23.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit
private let kMenuCellID = "kMenuCellID"
class AmuseMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var groups : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.size.width / 4
        let itemH = collectionView.bounds.size.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension AmuseMenuCollectionViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! CollectionViewGameCell
        cell.clipsToBounds = true
        cell.group = groups?[indexPath.row]
        return cell
    }
}

