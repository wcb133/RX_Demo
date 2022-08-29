//
//  ViewController.swift
//  RX_Demo
//
//  Created by fst on 2019/11/15.
//  Copyright © 2019 fst. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxSwiftExt
import UIKit
import NSObject_Rx
import SwiftMessages

class Person: NSObject {
    var name = ""
    var nums: [Int] = [1, 5, 9, 7, 5, 61]
}

extension ViewController {
    func testThread() {}
}

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var persons: [Person] = []

    var per = Person()

    weak var weakPerson: Person?

    var testArray: [Person] = []

//    var textArr:[String] {
//        set{
//            self.testArray = newValue
//        }
//        get {
//            return self.testArray
//        }
//    }

//    private let semaphore = DispatchSemaphore(value: 1)

    // 最大并发数
    private let operationQueue = OperationQueue().then { op in
        op.maxConcurrentOperationCount = 1
    }

    func testOb(element: String) -> Observable<String> {
        Observable<String>.create { ob in
            print(" ====== \(Thread.current)")
            let semaphoreT = DispatchSemaphore(value: 0)
            defer {
                semaphoreT.wait()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                semaphoreT.signal()
                ob.onCompleted()
            }
            return Disposables.create {
                print(" ====== 释放了")
            }
        }
    }

    func testDefer() -> String {
        defer {
            print("===== 测试defer")
        }
        return "defer"
    }

    override func viewDidLoad() {
        view.backgroundColor = .white

        let res = testDefer()
        print("defer ====== \(res) ==== \(self)")

        Observable.from(["1", "3", "6", "8", "3", "6", "8"]).flatMap { [unowned self] element in
            self.testOb(element: element).subscribe(on: OperationQueueScheduler(operationQueue: operationQueue))
        }.toArray().subscribe(onSuccess: { [unowned self] array in
            print("回调 ======== \(array)")
        }).disposed(by: rx.disposeBag)

//        return

        let p1 = Person()
        let p2 = Person()
        let p3 = Person()
        let array1 = [p1, p2]
        let array2 = [p1, p3]

        testArray = []

        print(" ======= \(array1 == array2)")
//        testArray.append("9")
//        print(String(format: " ======= %p", textArr))

//           let weakP = Person()
//           weakPerson = weakP
//
//           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//               print(" ======= \(String(describing: self.weakPerson))")
//           }
//
//
//           let person = self.per
//           DispatchQueue.global().async {
//               for _ in 0..<100000 {
//                   print(String.init(format: "后地址%p===%p", person,person.name))
//                   print("======\(self.per) ===== \(self.per.name)")
//               }
//           }
//
//           for i in 0..<1000 {
//               let p = Person()
//               per = p
//              p.name = "名字测试\(i)"
//           }

//           class Car {
//               var name: String = ""
//           }
//           var car = Car()
//           car.name = "大奔"
//           let block = { [tmpCar = car] in
//               print("我开\(tmpCar.name)")
//           }
//           car = Car()
//           car.name = "雅迪"
//           block()

//        return

        var p: [Person] = []
        for i in 0..<3 {
            let model = Person()
            model.name = "名字\(i)"
            p.append(model)
        }
        print(String(format: "前地址%p", persons))
        persons = p
        print(String(format: "后地址%p===%p", persons, p))

        let model = persons[2]
        let delay: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            DispatchQueue.global().async {
//                   let num = model.nums[3]
//                   print(String.init(format: " ====== %p", self.persons))
//                   print("======\(model.name) ====== \(num)")
                print("======\(UIScreen.main.scale)")
            }
        }

        persons = []

//           let model2 = self.persons[2]
//           model2.nums = []

//           var p2:[Person] = []
//           for i in 0..<2 {
//               let model = Person()
//               model.name = "p2测试名字\(i)"
//               model.nums = [9,5,3,4]
//               p2.append(model)
//           }
//
//           persons = p2
//
//           print(String.init(format: "删除后地址%p", persons))

//           for i in 0..<3 {
//               let model = Person()
//               model.name = "名字\(i)"
//               persons.append(model)
//           }

        rx.methodInvoked(#selector(ViewController.viewWillAppear(_:))).subscribe(onNext: { animate in
            print("数据 ========= \(animate)")
        }).disposed(by: disposeBag)

        view.backgroundColor = .white
        let lab = UILabel()
        view.addSubview(lab)
        lab.textColor = .red
        lab.frame = CGRect(x: 0, y: 100, width: 200, height: 20)

        // 测试takeUntil
//        takeUntilTest()

//           //Observable序列（每隔1秒钟发出一个索引数）
//        let observableTi = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//       let observableMap = observable.map { "当前索引数：\($0 )" }
//        observableMap.bind { print("当前索引数：\($0  )") }.disposed(by: disposeBag)

        let ob1: Observable<String> = Observable.just("")
        let ob2 = Observable.just("")

        let observable2 = Observable.of(ob1, ob2)

//        observable.composeMa
        // 订阅1
//        observable2.subscribe { event in
//            print("======= \(event)")
//            print("数据======= \(event.element)")
//
//        }.disposed(by: disposeBag)

//        let p = Person()

//        Observable.from([p]).mapAt(\.name).subscribe(onNext: { name in
//            print("数组 ======== \(name)")
//        }, onError: nil, onCompleted: nil, onDisposed: nil)

        observable2.subscribe { _ in

        } onError: { _ in
            print("数据======= onError")
        } onCompleted: {
            print("数据======= onCompleted")
        } onDisposed: {
            print("数据======= onDisposed")
        }.disposed(by: disposeBag)

        let observable = Observable.of("", "")

        // 订阅2
        observable.subscribe(onNext: { text in
            print(text)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("onCompleted")
        }) {
            print("dispose")
        }.disposed(by: disposeBag)

        // 订阅3
        observable.subscribe(onNext: { text in
            print("订阅3" + text)
        }).disposed(by: disposeBag)

        // 订阅4,观察者observer，结合bind使用
        let observer: AnyObserver<String> = AnyObserver { event in
            switch event {
            case let .next(text):
                print(text)
            case let .error(error):
                print(error)
            case .completed:
                print("完成")
            }
        }
        observable.map { "当前索引数：\($0)" }.bind(to: observer).disposed(by: disposeBag)
        // 订阅5，binder
        let observableTi = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        let binderObserver: Binder<String> = Binder(lab) { label, text in
            label.text = text
        }
        observableTi.map { "计算\($0)" }.bind(to: binderObserver).disposed(by: disposeBag)

        // 自定义可绑属性，其实RxSwift已经写有，label.rx.fontSize
//        observableTi.map { CGFloat($0) }.bind(to: lab.fontSize).disposed(by: disposeBag)
    }

    func takeUntilTest() {
        let source = Observable<String>.create { ob -> Disposable in
            Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance).subscribe(onNext: { _ in
                ob.onNext("数据")
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
        let notifier = PublishSubject<String>()

        let source2 = PublishSubject<String>()

        // 效果应该是和flatMapLatest一样的
        let source3 = source.flatMap {
            ob(text: $0).takeUntil(notifier)
        }.share(replay: 1)
//        let source3 = source.flatMapLatest {
//            ob(text: $0)
//        }.share(replay: 1)

        source3.subscribe(onNext: { text in
            print("=========== \(text)")
        }).disposed(by: disposeBag)

        func ob(text: String) -> Observable<Int> {
            return Observable.of(123)
        }

        // 停止接收消息
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
            notifier.onNext("z")
        }
    }
}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        view.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: view)
    }
}

// 通过对 UILabel 进行扩展，增加了一个fontSize 可绑定属性。
public extension UILabel {
    // 只读计算属性
    var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
