//
//  File.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/11.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
//    class func createItem(imageName: String, hightImageName : String, size: CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        let item = UIBarButtonItem(customView: btn)
//        return item
//    }
    
    convenience init(imageName : String, hightImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        if size != CGSize.zero {
           btn.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}

