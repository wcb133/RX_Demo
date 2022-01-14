//
//  SwiftCompileVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/14.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation
import UIKit

class SwiftCompileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Xcode会报一条黄色警告
        #warning("此处逻辑有问题,明天再说")

        // TODO:
        #warning("TODO: Update this code for the new iOS 12 APIs")

        // 手动设置一条错误
        // #error("This framework requires UIKit!")
        // #if - #endif 条件判断
        #if !canImport(UIKit)
            #error("This framework requires UIKit!")
        #endif

        #if DEBUG
            #warning("TODO: Update this code for the new iOS 12 APIs")
        #endif

        // #file、#function、#line
        log("日志测试")
        // #available和@available
        availableTest()
        // 真机模拟器判断
        #if targetEnvironment(simulator)
        // this is the simulator
        #else
            // this is a real device
        #endif
    }

    /// 自定义Log
    ///
    /// - Parameters:
    ///   - message: 输出的内容
    ///   - file: 默认
    ///   - method: 默认
    ///   - line: 默认
    func log<T>(_ message: T, file: NSString = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
            print("\(file.pathComponents.last!):\(method)[\(line)]: \(message)")
        #endif
    }

    func availableTest() {
        if #available(iOS 8, *) {
            // iOS 8 及其以上系统运行
        }

        guard #available(iOS 8, *) else {
            return // iOS 8 以下系统就直接返回
        }

        @available(iOS 11.4, *)
        func myMethod() {
            // do something
        }
    }
}
