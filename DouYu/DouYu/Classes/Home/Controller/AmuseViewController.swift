//
//  AmuseViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/22.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    lazy var amuseMenuView : AmuseMenuView = {
        let amuseMenuView = AmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return amuseMenuView
    }()
}

/// MARK:- 设置UI
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
}

/// MARK:- 加载数据
extension AmuseViewController {
    @objc override func loadData() {
        amuseVM.getAmuseData {

            self.baseVM = self.amuseVM
            self.collectionView.reloadData()
            self.amuseMenuView.anchorGroups = self.amuseVM.anchorGroups
            self.finishLoadData()
        }
    }
}
