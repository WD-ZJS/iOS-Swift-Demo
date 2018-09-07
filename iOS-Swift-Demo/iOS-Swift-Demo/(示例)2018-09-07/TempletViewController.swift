//
//  TempletViewController.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit
// MARK: ============ 第一步 继承----->BaseViewController ============
class TempletViewController: BaseViewController {

    private var textLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: ============ 第二步 重写四个方法 ============
    override func dataInitialization() {
        /// 初始化字符串、数组、字典等数据
    }
    
    override func setupNavagationBar() {
        /// 设置导航栏
        title = "示例样式"
    }
    
    override func setupSubViewsPropertys() {
        /// 添加控件，并设置属性
        /// 示例代码
        textLabel = UILabel.init()
        textLabel?.text = "示例样式"
        textLabel?.textColor = UIColor.init(red: CGFloat(arc4random_uniform(256))/255.0,
                                            green: CGFloat(arc4random_uniform(256))/255.0,
                                            blue: CGFloat(arc4random_uniform(256))/255.0,
                                            alpha: 1)
        textLabel?.font = UIFont.systemFont(ofSize: 90)
        textLabel?.textAlignment = .center
        view.addSubview(textLabel!)
    }
    
    override func setupSubViewsConstraints() {
        /// 对页面进行布局<推荐使用AutoLayout，不使用Frame布局>
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        let topConstrants = NSLayoutConstraint.init(item: textLabel!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leadingConstrants = NSLayoutConstraint.init(item: textLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trealingConstrants = NSLayoutConstraint.init(item: textLabel!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstrants = NSLayoutConstraint.init(item: textLabel!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([topConstrants ,leadingConstrants ,trealingConstrants ,bottomConstrants])
    }
    
    /// 默认有TableView
    /// TODO 其他
}
