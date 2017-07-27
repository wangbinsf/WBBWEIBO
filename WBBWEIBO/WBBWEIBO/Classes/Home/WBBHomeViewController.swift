//
//  WBBHomeTableViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBHomeViewController: WBBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogined {
            visitorView?.setUpVisitorInfo(image: nil, title: "关注一些人，回这里看看有什么惊喜")
        }
    }


}
