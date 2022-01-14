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
        test()
        return

        let tis: [Float] = [3, 5, 7, 10]

        tis.forEach { ti in

            Observable<Float>.just(ti).flatMap { time in
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
//            print("当前线程 ====== \(Thread.current)")
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

    func test() {
        let opblock = BlockOperation {
//            print("当前线程1 ====== \(Thread.current)")
            Thread.sleep(forTimeInterval: 5)
            print("恢复")
        }

        let opblock2 = BlockOperation {
            Thread.sleep(forTimeInterval: 5)
            print("当前线程2 ====== \(Thread.current)")
        }

        let opblock3 = BlockOperation {
//            Thread.sleep(forTimeInterval: 5)
            self.testDelay { string in
                print(" ======= \(string)")
            }
            print("当前线程3 ====== \(Thread.current)")
        }

        let opblock4 = BlockOperation {
            print("当前线程4 ====== \(Thread.current)")
        }
        let opblock5 = BlockOperation {
            print("当前线程5 ====== \(Thread.current)")
        }

        op.addOperation(opblock)
        op.addOperation(opblock2)
        op.addOperation(opblock3)
        op.addOperation(opblock4)
        op.addOperation(opblock5)
    }

    func testDelay(handle: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                handle("回调数据")
            }
        }
    }
}
