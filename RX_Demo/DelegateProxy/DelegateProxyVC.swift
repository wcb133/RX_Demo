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
            print(num)
        }).disposed(by: disposeBag)

        my.rx.strs.subscribe(onNext: { str in
            print(str)
        }).disposed(by: disposeBag)
    }
}
