//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by 王宾宾 on 2017/7/28.
//  Copyright © 2017年 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext:
        UIViewControllerContextTransitioning) {
        //转场容器
        let containerView = transitionContext.containerView
        //需要转场的视图
        let toView = transitionContext.view(forKey: .to)!
        //不管哪种情况，此视图都是动画视图
        let herbView = presenting ? toView : transitionContext.view(forKey: .from)!
        //转场前的准备
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        //初始化动画视图
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.minY)
            herbView.clipsToBounds = true
        }
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: herbView)
        let herbController = transitionContext.viewController(forKey: presenting ? .to : .from) as! HerbDetailsViewController
        if presenting {
            herbController.containerView.alpha = 0.0
        }
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
                       animations: {
                        herbView.transform = self.presenting ?
                            CGAffineTransform.identity : scaleTransform
                        herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                        herbController.containerView.alpha = self.presenting ? 1.0 : 0.0
        },
                       completion:{_ in
                        if !self.presenting {
                            self.dismissCompletion?()
                        }
                        transitionContext.completeTransition(true)
        }
        )
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = !presenting ? 0.0 : 20.0/xScaleFactor
        round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
        round.duration = duration / 2
        herbView.layer.add(round, forKey: nil)
        herbView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor
    }
}
