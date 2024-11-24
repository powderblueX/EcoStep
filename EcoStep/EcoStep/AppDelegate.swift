//
//  AppDelegate.swift
//  EcoStep
//
//  Created by admin on 2024/11/23.
//

import UIKit
import LeanCloud

class AppDelegate: NSObject, UIApplicationDelegate {
    // 当应用启动完成时会调用
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // LeanCloud 初始化代码
        do {
            try LCApplication.default.set(
                id: "ZlILvIHMmASgcQSwOhpS56hh-gzGzoHsz",           // 替换为你的 LeanCloud App ID
                key: "6gY84ZB5y6Hv5wV90Jt89JKP",         // 替换为你的 LeanCloud App Key
                serverURL: "https://zlilvihm.lc-cn-n1-shared.com" // 替换为你的 LeanCloud 服务地址
            )
        } catch {
            print("LeanCloud 初始化失败：\(error)")
        }

        return true
    }
}

