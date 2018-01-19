//
//  RecommendClclesView.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/17.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"
private let kCycleViewHeight : CGFloat = kScreenW * 3 / 8
class RecommendClclesView: UIView {

    /// 定义定时器
    var cycleTimer : Timer?

    var cycleModles : [CycleModel]? {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModles?.count ?? 0
            let indexPath = IndexPath(item: (cycleModles?.count ?? 0) * 1000, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)

            removeCycleTimer()
            addCycleTimer()

        }
    }
    // 属性控件
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置控件不随着父控件的拉伸而拉伸
//        self.autoresizingMask = autoresizingNone
        // 注册 cell
        collectionView.register(UINib(nibName: "CycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)


    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置 collectionView的 layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = collectionView.bounds.size
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.delegate = self;
    }

}

// 提供一个快速创建 View 的类方法
extension RecommendClclesView {
    class func recommendCyclesView() -> RecommendClclesView {
        return Bundle.main.loadNibNamed("RecommendClclesView", owner: nil, options: nil)?.first as! RecommendClclesView
    }
}

// UICollectionViewDataSource 协议
extension RecommendClclesView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModles?.count ?? 0) * 100000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CycleCollectionViewCell
        cell.cycleModel = cycleModles![indexPath.item % cycleModles!.count]
        return cell
    }
}

extension RecommendClclesView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.size.width) % (cycleModles?.count ?? 1)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

/// 对定时器的操作方法
extension RecommendClclesView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    private func removeCycleTimer() {
        cycleTimer?.invalidate() /// 从运行循环中移出
        cycleTimer = nil
    }
    @objc private func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.size.width
        collectionView.setContentOffset(CGPoint(x:offsetX, y: 0), animated: true)
    }
}
