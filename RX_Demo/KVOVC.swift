//
//  KVOVC.swift
//  RX_Demo
//
//  Created by fst on 2019/12/17.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KVOVC: UIViewController {
    let disposeBag = DisposeBag()
     //必须声明为dynamic类型。否则监听不到
    @objc dynamic var message = "hangge.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        //定时器（1秒执行一次）
        Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                //每次给字符串尾部添加一个感叹
                self.message.append("!")
            }).disposed(by: disposeBag)
         
        //监听message变量的变化
        _ = self.rx.observeWeakly(String.self, "message")
            .subscribe(onNext: { (value) in
            print(value ?? "")
        })
    }
    
}
