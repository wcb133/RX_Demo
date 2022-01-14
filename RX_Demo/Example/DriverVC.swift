//
//  DriverVC.swift
//  RX_Demo
//
//  Created by fst on 2019/12/17.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DriverVC: UIViewController {
    let disposeBag = DisposeBag()
    let inputTF: UITextField = .init()
    let inputTF1: UITextField = .init()

    let messageLab: UILabel = .init()
    let contentLab: UILabel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputTF.frame = CGRect(x: 10, y: 100, width: 150, height: 40)
        inputTF.backgroundColor = .red
        view.addSubview(inputTF)

        messageLab.frame = CGRect(x: 10, y: 150, width: 250, height: 40)
        messageLab.backgroundColor = .red
        view.addSubview(messageLab)

        contentLab.frame = CGRect(x: 10, y: 200, width: 250, height: 40)
        contentLab.backgroundColor = .red
        view.addSubview(contentLab)

        dealWithoutDriver()
//        dealWithDriver()
        inputTF.rx.text.asDriver().drive(inputTF1.rx.text).disposed(by: disposeBag)
        // ObservableType, ObserverType
    }

    func dealWithDriver() {
        let result = inputTF.rx.text.orEmpty.asDriver().debounce(RxTimeInterval.milliseconds(1)).flatMapLatest { self.dealwithData(inputText: $0).asDriver(onErrorJustReturn: "检测到了错误事件") }

        result.map { "输入的内容是\($0)" }.drive(messageLab.rx.text).disposed(by: disposeBag)

        result.map { "输入的内容是 = \($0)" }.drive(contentLab.rx.text).disposed(by: disposeBag)
    }

    func dealWithoutDriver() {
        // observeOn主线程，catchErrorJustReturn发生error时的处理，share解决多次订阅多次请求问题
        let result = inputTF.rx.text.skip(1).flatMap { [weak self]input -> Observable<Any> in
            (self?.dealwithData(inputText: input ?? ""))!.observeOn(MainScheduler.instance).catchErrorJustReturn("发生错误")
        }.share(replay: 1, scope: .whileConnected)
        // 第一次订阅
        result.subscribe(onNext: { text in
            self.messageLab.text = text as? String
        }, onError: { error in

        }, onCompleted: {}).disposed(by: disposeBag)

        // 第二次订阅
        result.subscribe { even in
            switch even {
            case let .next(text):
                self.contentLab.text = text as? String
            case let .error(error): // 这个方法不会走的，错误已经被catchErrorJustReturn处理了，一旦走了error或者是completed，那这个信号就无法在发出信号了
                print("发生错误 ===== \(error)")
            case .completed:
                print("完成 ===== ")
            }
        }.disposed(by: disposeBag)
    }

    // 模拟查询数据
    func dealwithData(inputText: String) -> Observable<Any> {
        print("调用函数创建可观察序列 ====== dealwithData")
        return Observable<Any>.create { ob -> Disposable in
            if inputText == "1234" {
                ob.onError(NSError(domain: "com.lgcooci.cn", code: 10086, userInfo: nil))
            }

            DispatchQueue.global().async {
                print("异步发送网路请求 =====  \(Thread.current)")
                ob.onNext(inputText)
                ob.onCompleted()
            }
            return Disposables.create()
        }
    }
}
