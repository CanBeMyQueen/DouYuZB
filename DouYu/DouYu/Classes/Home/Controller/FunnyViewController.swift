//
//  FunnyViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/25.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {
    lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero

        collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        funnyVM.loadFunnyData {
            self.baseVM = self.funnyVM
            self.collectionView.reloadData()
            self.finishLoadData()
        }
    }
}
