//
//  BaseViewController.swift
//  DouYu
//
//  Created by 张萌 on 2018/1/25.
//  Copyright © 2018年 JiaYin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?

    fileprivate lazy var loadImageView : UIImageView = { [unowned self] in
        let loadImageView = UIImageView(image: UIImage(named: "WechatIMG1"))
        loadImageView.animationImages = [UIImage(named: "WechatIMG1")!, UIImage(named: "WechatIMG2")!, UIImage(named: "WechatIMG3")!, UIImage(named: "WechatIMG4")!, UIImage(named: "WechatIMG5")!, UIImage(named: "WechatIMG6")!]
        loadImageView.animationDuration = 1
        loadImageView.center = self.view.center
        loadImageView.animationRepeatCount = LONG_MAX
        loadImageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return loadImageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BaseViewController {
    func setupUI() {
        view.backgroundColor = UIColor.white

        contentView?.isHidden = true

        view.addSubview(loadImageView)

        loadImageView.startAnimating()
    }

    func finishLoadData() {

        loadImageView.stopAnimating()
        loadImageView.isHidden = true
        contentView?.isHidden = false
    }
}

