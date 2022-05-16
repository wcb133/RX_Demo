//
//  vVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/6.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
// import NSObject+Rx

class ScheduleVC: UIViewController {
    let bag = DisposeBag()

    let op = OperationQueue().then {
        $0.maxConcurrentOperationCount = 3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tis: [Float] = [3, 5, 7, 10]
        // 队列 let queue = ConcurrentDispatchQueueScheduler.init(qos: .userInteractive)
        // 优先级（时效高到底） userInteractive、userInitiated、default、utility、background

        tis.forEach { ti in

            Observable<Float>.just(ti).flatMap { time -> Observable<Float> in
                print("第一个订阅 === \(Thread.current) ==\(ti)")
                return Observable.just(time)
            }.flatMap { time in
                self.testLoadData(ti: time)
            }.subscribe(on: OperationQueueScheduler(operationQueue: op)).subscribe(onNext: { time in
                print("回调 ===== \(time)")
            }).disposed(by: bag)
        }
    }

    func testLoadData(ti: Float) -> Single<String> {
        print("函数外面当前线程 ====== \(Thread.current) ==\(ti)")
        if ti == 7 {
            Thread.sleep(forTimeInterval: 5)
            print("恢复")
        }

        return .create { ob in
            print("最里面的当前线程 ====== \(Thread.current)")
            if ti == 7 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                    ob(.success("延迟 ====== \(ti)"))
                }
            } else {
                ob(.success("\(ti)"))
            }

            return Disposables.create()
        }
    }

    func testDelay(handle: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                handle("回调数据")
            }
        }
    }
}
