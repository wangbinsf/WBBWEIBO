//
//  WBBMainViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBMainViewController: UITabBarController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.orange
        addChildViewControllers()
    }
    
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

    private func addChildViewControllers() {
        //从网络或本地获取子控制器数据
        guard let filePath = Bundle.main.path(forResource: "MainVCSettings", ofType: "json") else { return }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: AnyObject]]
            for dict in jsonObject {
                let title = dict["title"] as? String
                let vcName = dict["vcName"] as? String
                let imageName = dict["imageName"] as? String
                addChildViewController(vcName, title: title, image: imageName)
            }
        } catch {
            addChildViewController("WBBHomeTableViewController", title: "首页", image: "tabbar_home")
            addChildViewController("WBBMessageViewController", title: "消息", image: "tabbar_message_center")
            addChildViewController("NullViewController", title: "", image: "")
            addChildViewController("WBBDiscoverViewController", title: "发现", image: "tabbar_discover")
            addChildViewController("WBBProfileViewController", title: "我", image: "tabbar_profile")
        }
    }
    
    private func addChildViewController(_ childControllerName: String?, title: String?, image: String?) {
        guard let name = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else { return }
        guard let childName = childControllerName, let barTitle = title, let barImage = image else { return }
        guard let typeCls = NSClassFromString(name + "." + childName) as? UIViewController.Type else { return }
        let childController = typeCls.init()
        childController.title = barTitle
        childController.tabBarItem.image = UIImage(named: barImage)
        childController.tabBarItem.selectedImage = UIImage(named: barImage + "_highlighted")
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
    // MARK: swift 中的所有东西都是编译是确定的，如果想让swift中的方法也支持动态派发，可以在方法前面加上@objc，就是告诉系统需要动态派发
    @objc private func compseBtnClick(_ btn: UIButton) {
        WBLog(btn)
    }

}
