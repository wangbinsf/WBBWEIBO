//
//  WBBMessageViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBMessageViewController: WBBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogined
        {
            visitorView?.setUpVisitorInfo(image: "visitordiscover_image_message", title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }
    }

}
