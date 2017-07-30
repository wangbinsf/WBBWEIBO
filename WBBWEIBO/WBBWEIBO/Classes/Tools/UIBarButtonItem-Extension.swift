//
//  UIBarButtonItem-Extension.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/28.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(normalImage: UIImage?, highlightImage: UIImage?, title: String?, target: Any?, action: Selector) {
        let buttonItem = UIButton()
        buttonItem.setImage(normalImage, for: .normal)
        buttonItem.setImage(highlightImage, for: .highlighted)
        buttonItem.setTitle(title, for: .normal)
        buttonItem.sizeToFit()
        buttonItem.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: buttonItem)
    }
}
