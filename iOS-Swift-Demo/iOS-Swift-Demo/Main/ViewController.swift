//
//  ViewController.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    /// 标题数组
    private var nameArray:Array<Array<String>>?
    /// 记录时间数组
    private var dateArray:Array<String>?
    /// 跳转控制器数组
    private var controllerArray:Array<Array<UIViewController>>?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavagationBar() {
        title = "SwiftDemo"
    }
    
    override func dataInitialization() {
        nameArray = [["Demo名称"], ["仿微信底部弹窗", "仿今日头条头部视图切换"]]
        dateArray = ["时间：如2018-09-07", "2018-09-07"]
        /// 初始化好的控制器
        controllerArray = [[TempletViewController()],[WDBottmSheetViewController(),WDSegemenViewController()]]
    }
    
    override func setupSubViewsPropertys() {
        view.addSubview(tableView)
    }
    
    override func setupSubViewsConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let topConstrants = NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leadingConstrants = NSLayoutConstraint.init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trealingConstrants = NSLayoutConstraint.init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstrants = NSLayoutConstraint.init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([topConstrants ,leadingConstrants ,trealingConstrants ,bottomConstrants])
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (nameArray?.count)!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray![section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateArray?[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellId")
        }
        cell?.textLabel?.text = nameArray![indexPath.section][indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let controller:UIViewController = controllerArray![indexPath.section][indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}


