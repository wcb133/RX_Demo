//
//  AppDelegate.swift
//  RX_Demo
//
//  Created by fst on 2019/11/15.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let a = ["123"]
        let v = a[safe: 1]
        print(" ===== \(String(describing: a[safe: 1]))")

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        StartupCommandsBuilder()
            .setKeyWindow(window!)
            .build()
            .forEach { $0.execute() }
        return true
    }
}