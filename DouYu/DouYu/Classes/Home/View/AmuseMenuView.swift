//
//  AmuseMenuView.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/23.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

private let AmuseMenuCellID = "AmuseMenuCellID"

class AmuseMenuView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    var anchorGroups : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "AmuseMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AmuseMenuCellID)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }

}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if anchorGroups == nil { return 0 }
        let pageNum = (anchorGroups?.count)! / 8
        pageControl.numberOfPages = pageNum
        return pageNum
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmuseMenuCellID, for: indexPath) as! AmuseMenuCollectionViewCell
        setupCellValue(cell: cell, indexPath: indexPath)
        return cell
    }

    private func setupCellValue(cell : AmuseMenuCollectionViewCell, indexPath: IndexPath) {
        let startIndex = indexPath.row * 8
        var endIndex = (indexPath.row + 1) * 8 - 1
        if endIndex > (anchorGroups?.count)! - 1 {
            endIndex = (anchorGroups?.count)! - 1
        }
        cell.groups = Array(anchorGroups![startIndex...endIndex])
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionView.contentOffset.x / collectionView.bounds.size.width)
    }
}
