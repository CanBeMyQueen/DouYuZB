//
//  RecommendViewController.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/18.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit
import Alamofire

private let kCycleViewHeight : CGFloat = kScreenW * 3 / 8
private let kGameViewHeight : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    // 懒加载 RecommengViewModel
    lazy var recommendVM : RecommondViewModel = RecommondViewModel()

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
}

extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewHeight + kGameViewHeight, 0, 0, 0)
    }
}

extension RecommendViewController {
    override func loadData()  {
        recommendVM.requestData {

            self.baseVM = self.recommendVM
            self.collectionView.reloadData()
            var anchorGroups = self.recommendVM.anchorGroups
            anchorGroups.removeFirst()
            anchorGroups.removeFirst()
            self.gameView.groups = anchorGroups
            self.finishLoadData()
        }
        recommendVM.requestCycleData {
            self.cycleView.cycleModles = self.recommendVM.CycleModels
        }
    }
}

// UICollectionView 的 dataSource 协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// 1.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kBeautifulItemHeight)
        }
        return CGSize(width: kItemWidth, height: kNormalItemHeight)
    }
    
}
