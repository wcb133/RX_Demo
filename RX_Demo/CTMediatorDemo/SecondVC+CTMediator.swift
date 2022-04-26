//
//  SecondVC+CTMediator.swift
//  RX_Demo
//
//  Created by wcb on 2022/4/23.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation
import CTMediator
import UIKit

// 参考文章 https://juejin.cn/post/7028469469013868552

/// 获取命名空间
let NAME_SPACE: String = { () -> String in
    Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as! String
}()

// 提供该扩展给宿主工程调用
extension CTMediator {
    func getSecondVC(title: String) -> UIViewController? {
        // swift的命名空间要加上
        let param = ["title": title, kCTMediatorParamsKeySwiftTargetModuleName: NAME_SPACE] as [AnyHashable: Any]
        let vc = performTarget(String(describing: SecondVC.self), action: "Extension_SecondVC", params: param, shouldCacheTarget: false) as? UIViewController
        return vc
    }
}

/*
 注意点
 1.Target对象必须要继承自NSObject
 2.Action方法必须带 @objc 前缀
 3.Action方法第一个参数不能有Argument Label
 */
class Target_SecondVC: NSObject {
    // 坑点，必须加 @objc，否则调用不到,第一个参数前面需要加下划线，否则也是调用不到这个方法
    @objc func Action_Extension_SecondVC(_ param: NSDictionary) -> UIViewController? {
        guard let title = param["title"] as? String else { return nil }
        return SecondVC(title: title)
    }
}
