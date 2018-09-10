//
//  WDSegemenViewController.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

class WDSegemenViewController: BaseViewController, WDSegemenViewDelegate, WDSegemenViewDataSource {
    
    var segmentView:WDSegemenView = WDSegemenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height+44, width: self.view.frame.width, height: self.view.frame.height)
        segmentView.delegete = self
        segmentView.dataSource = self
        self.view.addSubview(segmentView)
    }
    
    func segmentViewClickAtIndex(index: Int) {
       
    }
    
    func titleArrayOfSegmentView() -> Array<String> {
        return ["前天" , "昨天", "今天" , "明天", "后天" , "大后天", "大大后天" , "昨天昨天昨天昨天"]
    }
    
    func controllerOfSegementView() -> Array<UIViewController> {
        var array:Array<UIViewController> = Array()
        for _ in 0...7 {
            array.append(WDSegmentTestViewController())
        }
        return array
    }
}
