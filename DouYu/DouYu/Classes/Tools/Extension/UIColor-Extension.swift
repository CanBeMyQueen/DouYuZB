//
//  UIColor-Extension.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/12.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(colorLiteralRed: Float(r/255.0), green: Float(g/255.0), blue: Float(b/255.0), alpha: 1.0)
    }
}
