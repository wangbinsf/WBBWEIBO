//
//  Const.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/30.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import Foundation
import UIKit

struct Screen {
    static let bounds = UIScreen.main.bounds
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let midX = Screen.width / 2
    static let midY = Screen.height / 2
    static let center = CGPoint(x: Screen.midX, y: Screen.midY)
}

struct WeiboCommon {
    static let appKey = "1920945083"
    static let appSecret = "f6f6cf4251873b5fc3ab5f017b576c8e"
    static let redirect_uri = "http://www.95081.com"
}
