//
//  WDSegmentTestViewController.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/8.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

class WDSegmentTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(256))/255.0,
                                            green: CGFloat(arc4random_uniform(256))/255.0,
                                            blue: CGFloat(arc4random_uniform(256))/255.0,
                                            alpha: 1)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
