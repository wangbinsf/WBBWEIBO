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
