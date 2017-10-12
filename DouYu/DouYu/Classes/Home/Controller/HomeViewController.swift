//
//  HomeViewController.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/11.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigateBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = PageTitleView(frame: titleViewFrame, titles: titles)
//        pageTitleView.backgroundColor = UIColor.brown
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    lazy var pageContentView : PageContentView = { [weak self] in
        // 创建 frame
        let contentH = kScreenH - kStatusBarH - kNavigateBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigateBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 确定子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, paraentVc: self!)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    // 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置 UI 界面
        setupUI()
        
    }

    

}
// 设置 UI 界面
extension HomeViewController {
    internal func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar();
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar() {
        
        //1、设置zuo侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2、设置you侧的Item
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "image_my_history_click", size: size);
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size);
        
        let scanItem = UIBarButtonItem(imageName: "image_scan", hightImageName: "image_scan_click", size: size);
        
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
//        
//        let scanItem = UIBarButtonItem.createItem(imageName: "image_scan", hightImageName: "image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, scanItem]
        
    }
}

// titleView 的代理方法
extension HomeViewController : PageTitleViewDelegate {
    func changePageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func contentViewScroll(pageContentView: PageContentView, progess: CGFloat, currentIndex: Int, targetIndex: Int) {
//        print("progess\(progess) currentIndex\(currentIndex) targetIndex\(targetIndex)")
        pageTitleView.setTitleView(progress: progess, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}

