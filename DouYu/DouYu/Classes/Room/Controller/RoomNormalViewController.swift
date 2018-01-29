//
//  RoomNormalViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/25.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: false)

        // 保持手势返回
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }

}
