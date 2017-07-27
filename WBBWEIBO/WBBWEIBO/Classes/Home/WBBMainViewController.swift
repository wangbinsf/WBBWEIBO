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
        tabBar.tintColor = UIColor.orange
        addChildViewControllers()
    }

    func addChildViewControllers() {
        //从网络或本地获取子控制器数据
        guard let filePath = Bundle.main.path(forResource: "MainVCSettings", ofType: "json") else { return }
        guard let data = NSData(contentsOfFile: filePath) else { return }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [[String: AnyObject]]
            for dict in jsonObject {
                let title = dict["title"] as? String
                let vcName = dict["vcName"] as? String
                let imageName = dict["imageName"] as? String
                addChildViewController(vcName, title: title, image: imageName)
            }
        } catch {
            addChildViewController("WBBHomeTableViewController", title: "首页", image: "tabbar_home")
            addChildViewController("WBBMessageViewController", title: "消息", image: "tabbar_message_center")
            addChildViewController("WBBDiscoverViewController", title: "发现", image: "tabbar_discover")
            addChildViewController("WBBProfileViewController", title: "我", image: "tabbar_profile")
        }
    }
    
    func addChildViewController(_ childControllerName: String?, title: String?, image: String?) {
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
}
