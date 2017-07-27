//
//  WBBVisitor.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBVisitor: UIView {
    
    @IBOutlet var rotationImageview: UIImageView!
    
    @IBOutlet var iconImageview: UIImageView!
    
    @IBOutlet var showMessageLabel: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var registerButton: UIButton!
    
    class func visitor() -> WBBVisitor {
        return Bundle.main.loadNibNamed("WBBVisitor", owner: nil, options: nil)?.first as! WBBVisitor
    }

    func setUpVisitorInfo(image: String?, title: String) {
        showMessageLabel.text = title
        guard let name = image else {
            startAnimation()
            return
        }
        rotationImageview.isHidden = true
        iconImageview.image = UIImage(named: name)
    }
    
    func startAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        basicAnimation.toValue = 2 * Double.pi
        basicAnimation.repeatCount = MAXFLOAT
        basicAnimation.duration = 2.0
        basicAnimation.isRemovedOnCompletion = false
        rotationImageview.layer.add(basicAnimation, forKey: nil)
    }
}
