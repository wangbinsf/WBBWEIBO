//
//  UserAccount.swift
//  XMGWB
//
//  Created by xiaomage on 15/12/5.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {
    
    var access_token: String?
    var expires_in: Int = 0
    var uid: String?
    
    // MARK: - 生命周期方法
    init(dict: [String: AnyObject]) {
        super.init()
        // 如果要想初始化方法中使用KVC必须先调用super.init初始化对象
        // 如果属性是基本数据类型, 那么建议不要使用可选类型, 因为基本数据类型的可选类型在super.init()方法中不会分配存储空间
        self.setValuesForKeys(dict)
    }
    
    // 当KVC发现没有对应的key时就会调用
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        assert(!(value != nil), "发现了没有对应上的key")
    }
    override var description: String {
        // 将模型转换为字典
        let property = ["access_token", "expires_in", "uid"]
        let dict = dictionaryWithValues(forKeys: property)
        // 将字典转换为字符串
        return "\(dict)"
    }
    
    // MARK: - 外部控制方法
    // 归档模型
    func saveAccount() -> Bool {
        /*
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        // 2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("useraccount.plist")
        NJLog(filePath)
        */
        // 3.归档对象
        return NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    /// 定义属性保存授权模型
    static var account: UserAccount?
//    static let filePath: String = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("useraccount.plist")
    static let filePath: String = "useraccount.plist".cachesDir()
    
    // 解归档模型
    class func loadUserAccount() -> UserAccount? {
        // 1.判断是否已经加载过了
        if UserAccount.account != nil{
            WBLog("已经有加载过")
            // 直接返回
            return UserAccount.account
        }
        
        // 2.尝试从文件中加载
        WBLog("还没有加载过")
        /*
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        // 2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("useraccount.plist")
        */
        
        // 3.解归档对象
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.filePath) as? UserAccount else {
            return UserAccount.account
        }
        UserAccount.account = account
        
        return UserAccount.account
    }
    
    /// 判断用户是否登录
    class func isLogin() -> Bool {
        return UserAccount.loadUserAccount() != nil
    }
    
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.expires_in = aDecoder.decodeInteger(forKey: "expires_in") as Int
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
    }
}

