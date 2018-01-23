//
//  GameViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/19.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 10
private let kItemSizeW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemSizeH : CGFloat = kItemSizeW * 6 / 5
private let kHeaderH : CGFloat = 50
private let kCommonViewH : CGFloat = 90
private let kGameCellID : String = "kGameCellID"
private let kHeaderID : String = "kHeaderID"
class GameViewController: UIViewController {

    fileprivate lazy var gameVM : GameViewModel = GameViewModel()

    // 懒加载控件
    fileprivate lazy var collection : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemSizeW, height: kItemSizeH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)

        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection .register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collection.register( UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        return collection
    }()
    fileprivate lazy var topHeaderView : HeaderCollectionReusableView = {
        let topHeaderView = HeaderCollectionReusableView.headerCollectionReusableView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderH + kCommonViewH), width: kScreenW, height: kHeaderH)
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView
    }()
    fileprivate lazy var commonView : RecommendGameView = {
        let commonView = RecommendGameView.recommendGameView()
        commonView.frame = CGRect(x: 0, y: -kCommonViewH, width: kScreenW, height: kCommonViewH)
        return commonView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
}

// MARK: 设置UI
extension GameViewController {
    fileprivate func setupUI() {
        view.addSubview(collection)
        collection.addSubview(topHeaderView)
        collection.addSubview(commonView)
        collection.contentInset = UIEdgeInsetsMake(kHeaderH + kCommonViewH, 0, 0, 0)
    }
}

/// MARK:- 加载网络数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collection.reloadData()
            self.commonView.groups = Array(self.gameVM.games[0..<6])
        }
    }
}

extension GameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        cell.group = gameVM.games[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "kHeaderID", for: indexPath) as! HeaderCollectionReusableView
        headerView.titleLabel.text = "全部"
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
