//
//  WBBMainViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: 懒加载tabbarButton
    private lazy var composeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: .highlighted)
        btn.addTarget(self, action: #selector(compseBtnClick(_:)), for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.addSubview(composeButton)
        // 保存按钮尺寸
        let rect = composeButton.frame
        // 计算宽度
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        // 设置按钮的位置
        composeButton.center = tabBar.convert(tabBar.center, from: view)
        composeButton.bounds.size = CGSize(width: width, height: rect.height)
    }

    // MARK: swift 中的所有东西都是编译是确定的，如果想让swift中的方法也支持动态派发，可以在方法前面加上@objc，就是告诉系统需要动态派发
    @objc private func compseBtnClick(_ btn: UIButton) {
        WBLog(btn)
    }

}
