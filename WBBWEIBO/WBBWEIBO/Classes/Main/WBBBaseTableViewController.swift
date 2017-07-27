//
//  WBBBaseTableViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBBaseTableViewController: UITableViewController {
    
    let isLogined = false
    var visitorView: WBBVisitor?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func loadView() {
        isLogined ? super.loadView() : setupVisitor()
    }

    func setupVisitor() {
        visitorView = WBBVisitor.visitor()
        view = visitorView
    }
}
