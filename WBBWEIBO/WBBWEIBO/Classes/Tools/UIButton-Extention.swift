//
//  UIButton-Extention.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/28.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(image: UIImage?, selectImage: UIImage?, highlightedImage: UIImage?) {
        self.init()
        setImage(image, for: .normal)
        setImage(selectImage, for: .selected)
//        setImage(highlightedImage, for: .highlighted)
        
    }
}
