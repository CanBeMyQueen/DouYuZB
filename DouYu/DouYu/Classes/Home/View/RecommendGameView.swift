//
//  RecommendGameView.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/25.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit
private let kGameViewCellID = "kGameViewCellID"
class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!

    var groups : [AnchorGroupModel]? {
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .flexibleLeftMargin

        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
    }
}
// 提供一个快速创建 View 的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! CollectionViewGameCell
        cell.group = self.groups?[indexPath.item]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.brown : UIColor.gray
        return cell
    }


}

