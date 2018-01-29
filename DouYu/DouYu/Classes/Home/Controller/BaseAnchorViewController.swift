//
//  BaseAnchorViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/23.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kSectionHeaderH : CGFloat = 50

let kNormalCellID : String = "kNormalCellID"
let kBeautifulCellID : String = "kBeautifulCellID"
let kSectionHeaderID : String = "kSectionHeaderID"
let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemHeight : CGFloat = kItemWidth * 3 / 4
let kBeautifulItemHeight : CGFloat = kItemWidth * 5 / 4

class BaseAnchorViewController: BaseViewController {
    var baseVM : BaseAnchorViewModel!
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
extension BaseAnchorViewController {
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
}
/// MARK:- 加载网络
extension BaseAnchorViewController {
    func loadData() {

    }
}

extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseVM == nil {
            return 0
        }
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchorRooms.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        cell.anchorRoom = baseVM.anchorGroups[indexPath.section].anchorRooms[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderID, for: indexPath) as! HeaderCollectionReusableView
        headerView.group = self.baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了:\(indexPath)")
        let anchor = self.baseVM.anchorGroups[indexPath.section].anchorRooms[indexPath.item]
        anchor.isVertical == 0 ? pushNormalRoom() : presentShowRoom()

    }

    private func presentShowRoom() {
        let showRoomVC = RoomShowViewController()
        present(showRoomVC, animated: true, completion: nil)
    }
    private func pushNormalRoom() {
        let normalRoomVC = RoomNormalViewController()
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }

}

