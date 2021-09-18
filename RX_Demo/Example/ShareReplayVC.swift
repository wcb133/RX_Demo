//
//  ShareReplayVC.swift
//  RX_Demo
//
//  Created by fst on 2019/12/20.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ShareReplayVC: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //share减少map的操作次数
        let sequenceOfInts = PublishSubject<Int>()
        let a = sequenceOfInts.map{ i -> Int in
            print("MAP---\(i)")
            return i * 2
        }.share(replay: 1)
        
        a.subscribe(onNext: {
            print("--1--\($0)")
            }).disposed(by: disposeBag)
        
        sequenceOfInts.onNext(1)
        sequenceOfInts.onNext(2)
        //这里订阅的时候，会立即得到上次发送的数据，因为share共享状态变化
        a.subscribe(onNext: {
         print("--2--\($0)")
            }).disposed(by: disposeBag)

    }
}
