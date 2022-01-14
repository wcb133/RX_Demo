//
//  AppDelegateCommand.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/14.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

protocol Command {
    func execute()
}

struct InitializeThirdPartiesCommand: Command {
    func execute() {
        // 第三方库初始化代码
    }
}

struct InitialViewControllerCommand: Command {
    let keyWindow: UIWindow
    func execute() {
        // 根控制器设置代码
        let vc = RootVC()
        let nav = UINavigationController(rootViewController: vc)
        keyWindow.rootViewController = nav
    }
}

struct InitializeAppearanceCommand: Command {
    func execute() {
        // 全局外观样式配置
    }
}

struct RegisterToRemoteNotificationsCommand: Command {
    func execute() {
        // 远程推送配置
    }
}
