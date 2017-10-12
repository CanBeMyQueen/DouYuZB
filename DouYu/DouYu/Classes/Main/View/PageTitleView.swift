//
//  PageTitleView.swift
//  DouYu
//
//  Created by 张萌 on 2017/9/12.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func changePageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private var isForbitScrollDelegate = false


class PageTitleView: UIView {

    //定义属性
    var titles: [String]
    let kScrollLineH : CGFloat = 2
    var currentTag : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    
    let scrollLine : UIView = {
        let scrollLine = UIView()
        return scrollLine
    }()
    
    
    // 懒加载一个 label 数组，用于存放 title 的 label
    lazy var labels : [UILabel] = [UILabel]()
    
    //懒加载属性
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // 1.自定义一个构造函数
     init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置 UI 界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
     public func setupUI() {
        // 1.添加 UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加titles对应的label
        setupTitlesLabel()
        
        // 3.设置底部线条和滚动滑块
        setupBottomLineAndSrcollLine()
        
    }
    
    private func setupTitlesLabel() {
        
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - kScrollLineH
        let labelY = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.textAlignment = .center
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            let LabelX = labelW * CGFloat(index)
            
            label.frame = CGRect(x: LabelX, y: CGFloat(labelY), width: labelW, height: labelH)
            
            labels.append(label)
            
            scrollView.addSubview(label)
            
            //给 label 添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndSrcollLine() {
        // 添加底部线
        let bottomLine = UIView()
        let lineH : CGFloat = 0.5
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加滚动条
        self.scrollLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        // guard swift 语法
        guard let firstLabel = labels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
        
    }
    
   
    
}
 // 监听 label 的点击事件

extension PageTitleView {
    @objc public func titleLabelClick( tapGes : UITapGestureRecognizer) {
        print("====");
        // 获取当前点击的 label 并设置成选中色
        guard let currentLabel = tapGes.view as? UILabel else {return}
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        // 获取之前选中的 label 并改变颜色
        let oldlabel = labels[currentTag] as UILabel
        currentTag = currentLabel.tag
        oldlabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 设置滚动条：
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 通知代理
        delegate?.changePageTitleView(titleView: self, selectedIndex: currentTag)
        
    }
}

// 设置对外暴露的方法
extension PageTitleView {
    func setTitleView(progress : CGFloat, currentIndex: Int, targetIndex: Int) {
        
        // 1.获取当前 label 和目标 label
        let currentLabel = labels[currentIndex]
        let targetLabel = labels[targetIndex]
        
        // 2.处理滑块逻辑
        let totalX = targetLabel.frame.origin.x - currentLabel.frame.origin.x
        let moveX = totalX * CGFloat(progress)
        print("----- \(moveX)")
        scrollLine.frame.origin.x = currentLabel.frame.origin.x + moveX
        
        //3.处理文字颜色渐变
        //3.1 取出变化范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        
        currentLabel.textColor = UIColor(r: kSelectedColor.0 - (colorDelta.0 * progress), g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + (colorDelta.0 * progress), g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        currentTag = targetIndex
        
    }
}
