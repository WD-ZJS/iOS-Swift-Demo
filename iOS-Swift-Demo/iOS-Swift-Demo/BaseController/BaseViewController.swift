//
//  BaseViewController.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: ============ Public ============
    public lazy var tableView:UITableView = {
        let tableView = UITableView.init()
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView.init()
        tableView.estimatedRowHeight = 65
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: "baseCell")
        return tableView
    }()
    
    // ============ Set up navigation bar style ============
    public func setupNavagationBar() {}
    
    // ============ Add controls, set properties ============
    public func setupSubViewsPropertys() {}
    
    // ============ Setting control layout constraints ============
    public func setupSubViewsConstraints() {}
    
    // ============ Data initialization ============
    public func dataInitialization() {}
    
     // MARK: ============ deinit ============
    deinit {
        print("============\(type(of: self))被销毁了!============")
    }
    
    // MARK: ============ Controller Life Cycle ============
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        dataInitialization()
        setupNavagationBar()
        setupSubViewsPropertys()
        setupSubViewsConstraints()
    }

    // MARK: ============ DidReceiveMemoryWarning ============
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: ============ UITableViewDataSource ============
extension BaseViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuserIdentify = "baseCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentify, for: indexPath)
        return cell
    }
}

// MARK: ============ UITableViewDelegate ============
extension BaseViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
    }
}

