//
//  NetworkTools.swift
//  XMGWB
//
//  Created by xiaomage on 15/12/5.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {

    // Swift推荐我们这样编写单例
    static let shareInstance: NetworkTools = {

        // 注意: baseURL后面一定更要写上./
      let baseURL = URL(string: "https://api.weibo.com/")!
        
       let instance = NetworkTools(baseURL: baseURL, sessionConfiguration: URLSessionConfiguration.default)
        
        instance.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as? Set<String>
        
        return instance
    }()

}
