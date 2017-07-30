//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by 王宾宾 on 2017/7/28.
//  Copyright © 2017年 Razeware LLC. All rights reserved.
//

import UIKit

class WBBCustomPresentViewController: UIPresentationController {
    
    /*
     1.如果不自定义转场modal出来的控制器会移除原有的控制器
     2.如果自定义转场modal出来的控制器不会移除原有的控制器
     3.如果不自定义转场modal出来的控制器的尺寸和屏幕一样
     4.如果自定义转场modal出来的控制器的尺寸我们可以自己在containerViewWillLayoutSubviews方法中控制
     5.containerView 非常重要, 容器视图, 所有modal出来的视图都是添加到containerView上的
     6.presentedView() 非常重要, 通过该方法能够拿到弹出的视图
     */
    
    private lazy var coverBtn: UIButton = {
        let btn = UIButton()
        btn.frame = Screen.bounds
        btn.backgroundColor = .clear
        return btn
    }()
    
    fileprivate var presentFrame: CGRect?
    fileprivate var dismissCompletion: (() -> Void)?
    
    // 用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews() {
        guard let frame = presentFrame else {
            // 设置弹出视图的尺寸
            presentedView?.frame = CGRect(x: Screen.midX - 100, y: 45, width: 200, height: 200)
            return
        }
        presentedView?.frame = frame
    }
    
    // MARK: - 内部控制方法
    @objc private func coverBtnClick()
    {
        // 让菜单消失
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.addSubview(coverBtn)
        coverBtn.addTarget(self, action: #selector(coverBtnClick), for: .touchUpInside)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        WBLog(presentationTransitionDidEnd)
    }
    
    override func dismissalTransitionWillBegin() {
        WBLog(dismissalTransitionWillBegin)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        WBLog(dismissalTransitionDidEnd)
        dismissCompletion?()
    }
}

class PopAnimator: NSObject, UIViewControllerTransitioningDelegate {
    
    var duration = 1.0
    var isPresenting = true
    var originFrame: CGRect?
    var dismissCompletion: (() -> Void)?
    var willPresentBlock: (() -> Void)?
    var willDismissBlock: (() -> Void)?
    
    
    ///forPresented
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        willPresentBlock?()
        return self
    }
    ///forDismissed
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        willDismissBlock?()
        return self
    }
    ///代理控制器
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let customController = WBBCustomPresentViewController(presentedViewController: presented, presenting: presenting)
        customController.presentFrame = originFrame
        customController.dismissCompletion = dismissCompletion
        return customController
    }

}

extension PopAnimator: UIViewControllerAnimatedTransitioning {
    ///必须实现的2个方法
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext:
        UIViewControllerContextTransitioning) {
        isPresenting ? willPresentedController(transitionContext) : willDismissedController(transitionContext)
    }
    //present动画函数
    private func willPresentedController(_ transitionContext:
        UIViewControllerContextTransitioning) {
        //转场容器
        let containerView = transitionContext.containerView
        //需要转场的视图
        let toView = transitionContext.view(forKey: .to)!
        containerView.addSubview(toView)
        
        // 3.执行动画
        toView.transform = CGAffineTransform(scaleX: 0, y: 0)
        // 设置锚点
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            toView.transform = CGAffineTransform.identity
        }, completion: { (_) -> Void in
            // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        })
    }
    //dismiss动画函数
    private func willDismissedController(_ transitionContext:
        UIViewControllerContextTransitioning) {
        // 1.拿到需要消失的视图
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        // 2.执行动画让视图消失
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            // 突然消失的原因: CGFloat不准确, 导致无法执行动画, 遇到这样的问题只需要将CGFloat的值设置为一个很小的值即可
            fromView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }, completion: { (_) -> Void in
            // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        })
    }
    
}


