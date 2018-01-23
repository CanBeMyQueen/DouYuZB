//
//  AmuseViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/22.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemHeight : CGFloat = kItemWidth * 3 / 4
private let kBeautifulItemHeight : CGFloat = kItemWidth * 5 / 4
private let kSectionHeaderH : CGFloat = 50

private let kNormalCellID : String = "kNormalCellID"
private let kBeautifulCellID : String = "kBeautifulCellID"
private let kSectionHeaderID : String = "kSectionHeaderID"

class AmuseViewController: UIViewController {
    lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    // 懒加载 UICollectionView
    lazy var collectionView : UICollectionView = {[unowned self] in

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSectionHeaderH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        // 注册 CollectionCell
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)

        collectionView.register(UINib(nibName: "BeautifulCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kBeautifulCellID)
        // 注册 sectionHeaderView
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
        return collectionView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

/// MARK:- 设置UI
extension AmuseViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

/// MARK:- 加载数据
extension AmuseViewController {
    fileprivate func loadData() {
        amuseVM.getAmuseData {
            self.collectionView.reloadData()
        }
    }
}

extension AmuseViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.amuseVM.amuseGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.amuseVM.amuseGroups[section].anchorRooms.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        cell.anchorRoom = self.amuseVM.amuseGroups[indexPath.section].anchorRooms[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderID, for: indexPath) as! HeaderCollectionReusableView
        headerView.group = self.amuseVM.amuseGroups[indexPath.section]
        return headerView
    }
}

