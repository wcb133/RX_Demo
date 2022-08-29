//
//  AppDelegate.swift
//  RX_Demo
//
//  Created by fst on 2019/11/15.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import FLEX

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(" ======= 前面")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        StartupCommandsBuilder()
            .setKeyWindow(window!)
            .build()
            .forEach { $0.execute() }

        // Swift
        FLEXManager.shared.showExplorer()

        return true
    }
}
