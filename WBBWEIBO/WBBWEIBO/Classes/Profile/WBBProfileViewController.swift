//
//  WBBProfileViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBProfileViewController: WBBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogined
        {
            visitorView?.setUpVisitorInfo(image: "visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }
    }

}
