//
//  WDBottmSheetViewController.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

class WDBottmSheetViewController: BaseViewController {

    private var noCanbutton:UIButton?
    private var hasCanbutton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: ============ 第二步 重写四个方法 ============
    override func dataInitialization() {
        /// 初始化字符串、数组、字典等数据
    }
    
    override func setupNavagationBar() {
        title = "仿微信底部弹窗"
    }
    
    override func setupSubViewsPropertys() {
        noCanbutton = UIButton.init(type: .custom)
        noCanbutton?.setTitle("没有取消按钮", for: .normal)
        noCanbutton?.backgroundColor = UIColor.blue
        noCanbutton?.setTitleColor(UIColor.white, for: .normal)
        noCanbutton?.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(noCanbutton!)
        
        hasCanbutton = UIButton.init(type: .custom)
        hasCanbutton?.setTitle("有取消按钮", for: .normal)
        hasCanbutton?.backgroundColor = UIColor.blue
        hasCanbutton?.setTitleColor(UIColor.white, for: .normal)
        hasCanbutton?.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(hasCanbutton!)
    }
    
    override func setupSubViewsConstraints() {
        /// 对页面进行布局<推荐使用AutoLayout，不使用Frame布局>
        noCanbutton?.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstrants = NSLayoutConstraint.init(item: noCanbutton!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50)
        let trealingConstrants = NSLayoutConstraint.init(item: noCanbutton!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -50)
        let bottomConstrants = NSLayoutConstraint.init(item: noCanbutton!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -10)
        view.addConstraints([leadingConstrants ,trealingConstrants ,bottomConstrants])
        
        hasCanbutton?.translatesAutoresizingMaskIntoConstraints = false
        let has_leadingConstrants = NSLayoutConstraint.init(item: hasCanbutton!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50)
        let has_trealingConstrants = NSLayoutConstraint.init(item: hasCanbutton!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -50)
        let has_bottomConstrants = NSLayoutConstraint.init(item: hasCanbutton!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 10)
        view.addConstraints([has_leadingConstrants ,has_trealingConstrants ,has_bottomConstrants])
    }
    
    
    @objc private func buttonAction(sender:UIButton) {
        if sender.titleLabel?.text == "没有取消按钮" {
            WDBottmActionSheet.init(titleArray: ["拍照", "打开相册"], cancelButtonTitle: "", delegate: self)
        } else {
            WDBottmActionSheet.init(titleArray: ["拍照", "打开相册"], cancelButtonTitle: "取消", delegate: self)
        }
    }
}

extension WDBottmSheetViewController:WDActionSheetDelegate {
    func selectedIndex(index: Int) {
        print("\(index)")
    }
}
