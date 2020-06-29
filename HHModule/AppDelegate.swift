//
//  AppDelegate.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var rootModule = RootModule(parentContext: Context())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        self.window = window
        let rootViewController: RootViewController? = rootModule.parentContext.service()
        window.rootViewController = UINavigationController(rootViewController: rootViewController!)
        window.makeKeyAndVisible()
        return true
    }
}

