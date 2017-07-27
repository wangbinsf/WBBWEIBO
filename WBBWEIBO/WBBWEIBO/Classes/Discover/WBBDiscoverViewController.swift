//
//  WBBDiscoverViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBDiscoverViewController: WBBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogined
        {
            visitorView?.setUpVisitorInfo(image: "visitordiscover_image_message", title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }
    }

}
