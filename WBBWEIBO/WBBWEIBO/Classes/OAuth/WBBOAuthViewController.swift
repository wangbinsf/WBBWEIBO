//
//  WBBOAuthViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/8/5.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit

class WBBOAuthViewController: UIViewController {
    
    @IBOutlet var customWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.weibo.com/oauth2/authorize?client_id=1920945083&redirect_uri=www.95081.com")!
        let request = URLRequest(url: url)
        customWebView.loadRequest(request)
    }

}

extension WBBOAuthViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //调起登录界面https://api.weibo.com/oauth2/authorize?client_id=1920945083&redirect_uri=www.95081.com
        //登录https://api.weibo.com/oauth2/authorize
        //授权成功http://www.95081.com/?code=c51924d6fbedd389c5fd1e732e91a855
        //取消授权http://www.95081.com/?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
        guard let urlStr = request.url?.absoluteString else { return false }
        //取消回调界面跳转
        guard urlStr.hasPrefix("http://www.95081.com/") else { return true }
        guard let query = request.url!.query else { return false }
        let key = "code="
        if query.hasPrefix(key) {
            let code = request.url!.query?.substring(from: key.endIndex)
            requestAccessToken(code)
            return false
        }
        
        return false
    }
    
    ///获取access_token
    private func requestAccessToken(_ codeStr: String?) {
        guard let code = codeStr else { return }
        let path = "oauth2/access_token"
        let parameters = ["client_id": WeiboCommon.appKey, "client_secret": WeiboCommon.appSecret, "grant_type": "authorization_code", "code": code, "redirect_uri": WeiboCommon.redirect_uri]
        NetworkTools.shareInstance.post(path, parameters: parameters, constructingBodyWith: nil, progress: nil, success: { (dataTask, object) in
            WBLog(object)
            let account = UserAccount(dict: object as! [String: AnyObject])
            WBLog(UserAccount.saveAccount(account))
        }) { (dataTask, error) in
            WBLog(error)
            let account = UserAccount(dict: ["access_token": "wangbinbin" as AnyObject, "expires_in": 123 as AnyObject, "uid": "fuminmin" as AnyObject])
            WBLog(account.saveAccount())
        }
    }
}
