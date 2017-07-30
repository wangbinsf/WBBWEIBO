//
//  TitleButton.swift
//  XMGWB
//
//  Created by xiaomage on 15/12/2.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    // 通过纯代码创建时调用
    // 在Swift中如果重写父类的方法, 必须在方法前面加上override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///便利构造器必须最终调用本类中的指定构造器
    convenience init(image: UIImage?, selectImage: UIImage?, title: String?, selectTitle: String?) {
        self.init()
        setImage(image, for: .normal)
        setImage(selectImage, for: .selected)
        setTitle(title, for: .normal)
        setTitle(selectTitle, for: .selected)
        adjustsImageWhenHighlighted = false
    }
    // 通过XIB/SB创建时调用
    required init?(coder aDecoder: NSCoder) {
        // 系统对initWithCoder的默认实现是报一个致命错误
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }

    fileprivate func setupUI() {
        setTitleColor(.darkGray, for: .normal)
        sizeToFit()
    }

    override func setTitle(_ title: String?, for state: UIControlState) {
        // ?? 用于判断前面的参数是否是nil, 如果是nil就返回??后面的数据, 如果不是nil那么??后面的语句不执行
        super.setTitle((title ?? "") + "  ", for: state)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*
        // offsetInPlace 方法用于设置控件的偏移位
        titleLabel?.frame.offsetInPlace(dx: -imageView!.frame.width * 0.5, dy: 0)
        imageView?.frame.offsetInPlace(dx: titleLabel!.frame.width * 0.5, dy: 0)
        */
        
        // 和OC不太一样, Swift语法允许我们直接修改一个对象的结构体属性的成员
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.width
    }
}
