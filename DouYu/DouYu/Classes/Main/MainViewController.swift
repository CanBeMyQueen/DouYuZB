//
//  MainViewController.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/11.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let VC = UIViewController()
//        VC.view.backgroundColor = UIColor.white
//        addChildViewController(VC)
        
        // 1.通过 storyboard 获取控制器
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Mine")
    }

    private func addChildVc(storyName : String) {
        
        let VC = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(VC)
        
    }

}
