//
//  WDSegmentTestViewController.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/8.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

class WDSegmentTestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint.init(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: self.tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trealing = NSLayoutConstraint.init(item: self.tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem:view , attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([top, leading, trealing, bottom])
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let reuserIdentify = "baseCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentify, for: indexPath)
            
            cell.textLabel?.text = "\(indexPath.row)"
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView .deselectRow(at: indexPath, animated: true)
        }
    }
}
