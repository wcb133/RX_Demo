//
//  DelegateProxyVC.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/14.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class DelegateProxyVC: UIViewController {
    let my: MyClass = .init()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        my.start()

        my.rx.nums.subscribe(onNext: { num in
            print("rx回调nums ====== \(num)")
        }).disposed(by: disposeBag)

        my.rx.strs.subscribe(onNext: { str in
            print("rx回调strs ====== \(str)")
        }).disposed(by: disposeBag)

        my.rx.getName { age in
            print("rx回调getName ====== \(age)")
            return "张三"
        }
        // 实现了代理之后，居然不再回调rx了~~~
        my.delegate = self
    }
}

extension DelegateProxyVC: MyDelegate {
    func printNum(num: Int) {
        print(" ======= 这是代理输出")
    }

    func getName(age: Int) -> String {
        print(" ======= 这是代理返回")
        return "代理返回的名字========= 张三"
    }
}
