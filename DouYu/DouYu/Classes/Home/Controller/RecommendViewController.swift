//
//  RecommendViewController.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/18.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit
import Alamofire

private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemHeight : CGFloat = kItemWidth * 3 / 4
private let kBeautifulItemHeight : CGFloat = kItemWidth * 5 / 4
private let kSectionHeaderH : CGFloat = 50
private let kCycleViewHeight : CGFloat = kScreenW * 3 / 8
private let kGameViewHeight : CGFloat = 90

private let kNormalCellID : String = "kNormalCellID"
private let kBeautifulCellID : String = "kBeautifulCellID"
private let kSectionHeaderID : String = "kSectionHeaderID"

class RecommendViewController: UIViewController {

    // 懒加载 RecommengViewModel
    lazy var recommendVM : RecommondViewModel = RecommondViewModel()

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
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegateFlowLayout
        // 注册 CollectionCell
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "BeautifulCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kBeautifulCellID)
        // 注册 sectionHeaderView
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
        return collectionView
        
    }()

    lazy var cycleView : RecommendClclesView = { () -> RecommendClclesView in 
        let cycleView = RecommendClclesView.recommendCyclesView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewHeight + kGameViewHeight), width: kScreenW, height: kCycleViewHeight)
        return cycleView
    }()

    lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewHeight, width: kScreenW, height: kGameViewHeight)
        return gameView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple

        // 1.设置 UI
        setupUI()
        // 2.请求数据
        loadData()
    }


}

extension RecommendViewController {
    public func setupUI() {
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewHeight + kGameViewHeight, 0, 0, 0)
    }
}

extension RecommendViewController {
    func loadData()  {
        recommendVM.requestData {
            self.collectionView.reloadData()
            self.gameView.groups = self.recommendVM.ancharGroups
        }
        recommendVM.requestCycleData {
            self.cycleView.cycleModles = self.recommendVM.CycleModels
        }
    }
}

// UICollectionView 的 dataSource 协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.ancharGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.ancharGroups[section]
        return group.anchorRooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// 1.取出模型对象
        let group = recommendVM.ancharGroups[indexPath.section]
        let anchor = group.anchorRooms[indexPath.item]

        var cell = BaseCollectionViewCell()
        if indexPath.section == 1 {
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautifulCellID, for: indexPath) as! BeautifulCollectionViewCell
        } else {
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        }
        cell.anchorRoom = anchor
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderID, for: indexPath) as! HeaderCollectionReusableView
        let group = recommendVM.ancharGroups[indexPath.section]
        headerView.group = group
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kBeautifulItemHeight)
        }
        return CGSize(width: kItemWidth, height: kNormalItemHeight)
    }
    
}
