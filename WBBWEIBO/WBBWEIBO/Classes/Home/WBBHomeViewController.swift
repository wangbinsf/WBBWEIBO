//
//  WBBHomeTableViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBHomeViewController: WBBBaseTableViewController {

    private lazy var transition: PopAnimator = {
        let animator = PopAnimator()
        animator.originFrame = CGRect(x: Screen.midX - 100, y: 45, width: 200, height: 200)
        animator.duration = 0.5
        return animator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogined {
            visitorView?.setUpVisitorInfo(image: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        transition.dismissCompletion = {
            WBLog("dismissCompletion")
        }
        setUpNavBar()
    }
    
    private func setUpNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImage: #imageLiteral(resourceName: "navigationbar_friendattention"), highlightImage: #imageLiteral(resourceName: "navigationbar_friendattention_highlighted"),title: nil, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(normalImage: #imageLiteral(resourceName: "navigationbar_pop"), highlightImage: #imageLiteral(resourceName: "navigationbar_pop_highlighted"),title: nil, target: self, action: #selector(rightBarButtonClicked))
        let titleButton = TitleButton(image: #imageLiteral(resourceName: "navigationbar_arrow_down"), selectImage: #imageLiteral(resourceName: "navigationbar_arrow_up"), title: "wangbinsf", selectTitle: "wangbinsf")
        titleButton.addTarget(self, action: #selector(titleButtonClicked(_:)), for: .touchUpInside)
        navigationItem.titleView = titleButton
    }
    
    @objc private func leftBarButtonClicked() {
        WBLog(1)
    }
    @objc private func rightBarButtonClicked() {
        WBLog(2)
    }
    @objc private func titleButtonClicked(_ sender: TitleButton) {
        transition.willPresentBlock = {
            sender.isSelected = true
        }
        transition.willDismissBlock = {
            sender.isSelected = false
        }
        let popStoryboard = UIStoryboard(name: "Popview", bundle: nil)
        let popVC = popStoryboard.instantiateViewController(withIdentifier: "WBBPopViewController") as! WBBPopViewController
        popVC.modalPresentationStyle = .custom
        popVC.transitioningDelegate = transition
        present(popVC, animated: true, completion: nil)
    }

}

