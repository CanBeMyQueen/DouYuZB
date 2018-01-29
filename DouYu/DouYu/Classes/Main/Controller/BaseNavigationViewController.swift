//
//  BaseNavigationViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/25.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 通过运行时机制，获取到系统的target、action
        // pop-->view-->target/action
        // panGes -->View-->target/action
        //1.获取系统手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        //2.获取手势的View
        guard let gesView = systemGes.view else { return }
        //3. 获取target、action
        // 3.1利用运行时机制获取所有属性名称
        /*
            var count : UInt32 = 0
            let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
            for i in 0..<Int(count) {
                let ivar = ivars![Int(i)]
                let name = ivar_getName(ivar)
                print(String(utf8String: name!) as Any)
            }
            free(ivars)
         */

        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        //print(targetObjc)
        // (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fc0ca614c30>)
        // 取target
        guard let target = targetObjc.value(forKey: "target") else { return }
        // 取 action
        let action = Selector(("handleNavigationTransition:"))
        //4. 创建手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true

        super.pushViewController(viewController, animated: animated)

    }
}

