//
//  PageContentView.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/12.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

private let collectionCellID = "collectionCellID"

private var isForbitScrollDelegate : Bool = false

protocol PageContentViewDelegate : class {
    func contentViewScroll(pageContentView : PageContentView, progess : CGFloat, currentIndex : Int, targetIndex : Int)
}

class PageContentView: UIView {
    
    //定义属性
    var childVcs : [UIViewController]
    weak var paraentVc : UIViewController?
    var currentOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    // 懒加载添加 UICollection
    lazy var collectionView : UICollectionView = {[weak self] in
        
        //1.创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建 collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.dataSource = (self)!
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        return collectionView
    }()
    
    
    // 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], paraentVc : UIViewController) {
        self.childVcs = childVcs
        self.paraentVc = paraentVc
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    public func setupUI() {
        // 将所有子控制器，添加父付控制器中
        for childVc in childVcs {
            paraentVc?.addChildViewController(childVc)
        }
        
        // 添加 UICollctionView， 用于在 cell 上存放控制器的 view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// UICollectionView的dataSource 协议
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// UICollectionView的 delegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbitScrollDelegate = false
        currentOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if  isForbitScrollDelegate {
            return
        }
        var progress : CGFloat = 0 // 偏移比例
        var currentIndex : Int = 0 // 当前页码
        var targetIndex : Int = 0 // 目标页码
        let contentOffsetX = scrollView.contentOffset.x
        let contentViewW = scrollView.frame.size.width
        // 1.先判断左移还是右移动
        if contentOffsetX - currentOffsetX > 0 { // 左移
            progress = CGFloat((contentOffsetX / contentViewW) - floor(contentOffsetX / contentViewW))
            currentIndex = Int(contentOffsetX / contentViewW)
            targetIndex = currentIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if contentOffsetX == currentOffsetX + contentViewW {
                progress = 1
                targetIndex = currentIndex
            }
        } else { // 右移
            progress = 1 - CGFloat((contentOffsetX / contentViewW) - floor(contentOffsetX / contentViewW))
            targetIndex = Int(contentOffsetX / contentViewW)
            currentIndex = targetIndex + 1
            if currentIndex >= childVcs.count {
                currentIndex = childVcs.count - 1
            }
        }
        print("progress \(progress) currentIndex \(currentIndex) targetIndex \(targetIndex)")
        delegate?.contentViewScroll(pageContentView: self, progess: progress, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}

// 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int){
//        print(currentIndex)
        isForbitScrollDelegate = true
        let scrollOffsetX = CGFloat(currentIndex) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: scrollOffsetX, y: 0), animated: false)
    }
}

