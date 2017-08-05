//
//  WBBBaseTableViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBBaseTableViewController: UITableViewController {
    
    let isLogined = UserAccount.isLogin()
    var visitorView: WBBVisitor?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        isLogined ? super.loadView() : setupVisitor()
    }

    private func setupVisitor() {
        visitorView = WBBVisitor.visitor()
        view = visitorView
        
        visitorView?.loginButton.addTarget(self, action: #selector(loginBtnClick(_:)), for: .touchUpInside)
        visitorView?.registerButton.addTarget(self, action: #selector(registerBtnClick(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(registerBtnClick(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(loginBtnClick(_:)))
    }
    
    /// 监听登录按钮点击
    @objc private func loginBtnClick(_ btn: UIButton) {
        let oauthStoryboard = UIStoryboard(name: "OAuth", bundle: nil)
        let oauthVc = oauthStoryboard.instantiateInitialViewController()
        present(oauthVc!, animated: true, completion: nil)
        
    }
    /// 监听注册按钮点击
    @objc private func registerBtnClick(_ btn: UIButton) {
        WBLog("")
    }
}
