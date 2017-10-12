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

private let kNormalCellID : String = "kNormalCellID"
private let kBeautifulCellID : String = "kBeautifulCellID"
private let kSectionHeaderID : String = "kSectionHeaderID"

class RecommendViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        // Do any additional setup after loading the view.
        
        Alamofire.request("http://httpbin.org/get", method: .get).responseJSON { (dataresponse) in
//            print(dataresponse)
        }
        Alamofire.request("http://httpbin.org/post", method: .post, parameters: ["name": "why"]).responseJSON { (dataresponse) in
            print(dataresponse)
            guard let result = dataresponse.result.value else {
                print(dataresponse.result.error)
                return
            }
            print(result)
        }
//        Alamofire.request("http://httpbin.org/post", method: .post, parameters: {"name": "any"}).responseJSON { (dataresponse) in
//            print(dataresponse)
//        }
        // 1.设置 UI
        setupUI()
    }


}

extension RecommendViewController {
    public func setupUI() {
        view.addSubview(collectionView)
    }
}

// UICollectionView 的 dataSource 协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautifulCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderID, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kBeautifulItemHeight)
        }
        return CGSize(width: kItemWidth, height: kNormalItemHeight)
    }
    
}
