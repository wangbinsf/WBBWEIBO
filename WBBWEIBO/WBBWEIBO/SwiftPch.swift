//
//  SwiftPch.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/27.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import Foundation

func WBLog<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNum: Int = #line) {
    #if DEBUG
        print("\((fileName as NSString).lastPathComponent).\(methodName)[\(lineNum)]:\(message)")
    #endif
}
