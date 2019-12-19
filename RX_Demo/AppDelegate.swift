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
//        let vc = ViewController()
//        let vc = SubjectsVC()
//        let vc = KVOVC()
//        let vc = TransformingVC()
        let vc = DriverVC()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

}

