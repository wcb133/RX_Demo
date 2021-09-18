//
//  ViewController.swift
//  RX_Demo
//
//  Created by fst on 2019/11/15.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class Person {
    var name = ""
}

class ViewController: UIViewController {

       let disposeBag = DisposeBag()
       override func viewDidLoad() {
        
        self.rx.methodInvoked(#selector(ViewController.viewWillAppear(_:))).subscribe(onNext:{ animate in
            print("数据 ========= \(animate)")
        }).disposed(by: disposeBag)

       view.backgroundColor = .white
       let lab = UILabel()
        view.addSubview(lab)
        lab.textColor = .red
        lab.frame = CGRect(x: 0, y: 100, width: 200, height: 20)
        
        //测试takeUntil
//        takeUntilTest()
        
//           //Observable序列（每隔1秒钟发出一个索引数）
//        let observableTi = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//       let observableMap = observable.map { "当前索引数：\($0 )" }
//        observableMap.bind { print("当前索引数：\($0  )") }.disposed(by: disposeBag)
        
        let ob1:Observable<String> = Observable.just("")
        let ob2 = Observable.just("")
        
        let observable2 = Observable.of(ob1,ob2)
        
//        observable.composeMa
        //订阅1
//        observable2.subscribe { event in
//            print("======= \(event)")
//            print("数据======= \(event.element)")
//
//        }.disposed(by: disposeBag)
        
        let p = Person()
        
//        Observable.from([p]).mapAt(\.name).subscribe(onNext: { name in
//            print("数组 ======== \(name)")
//        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        observable2.subscribe { ob in
            
        } onError: { error in
            print("数据======= onError")
        } onCompleted: {
            print("数据======= onCompleted")
        } onDisposed: {
            print("数据======= onDisposed")
        }.disposed(by: disposeBag)

        
        
        let observable = Observable.of("","")
        
        //订阅2
       observable.subscribe(onNext: { (text) in
            print(text)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("onCompleted")
        }) {
            print("dispose")
        }.disposed(by: disposeBag)
        
        //订阅3
        observable.subscribe(onNext: { (text) in
            print("订阅3" + text)
            }).disposed(by: disposeBag);
        
        //订阅4,观察者observer，结合bind使用
        let observer:AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let text):
                print(text)
            case .error(let error):
                print(error)
            case .completed:
                print("完成")
            }
        }
        observable.map { "当前索引数：\($0 )" }.bind(to: observer).disposed(by: disposeBag)
        //订阅5，binder
        let observableTi = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        let binderObserver:Binder<String> = Binder(lab) { (label, text) in
            label.text = text
        }
        observableTi.map { "计算\($0)"}.bind(to: binderObserver).disposed(by: disposeBag)
        
        //自定义可绑属性，其实RxSwift已经写有，label.rx.fontSize
//        observableTi.map { CGFloat($0) }.bind(to: lab.fontSize).disposed(by: disposeBag)
       }
    
    
    func takeUntilTest() {
        let source = Observable<String>.create { (ob) -> Disposable in
            Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance).subscribe(onNext: { (ti) in
                ob.onNext("数据")
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
        let notifier = PublishSubject<String>()
        
        let source2 = PublishSubject<String>()
        
        //效果应该是和flatMapLatest一样的
        let source3 = source.flatMap({
            ob(text: $0).takeUntil(notifier)
            }).share(replay: 1)
//        let source3 = source.flatMapLatest {
//            ob(text: $0)
//        }.share(replay: 1)
        
        source3.subscribe(onNext: { (text) in
            print("=========== \(text)")
            }).disposed(by: disposeBag)
        
        
        func ob(text:String)->Observable<Int> {
            return Observable.of(123)
        }

         
        //停止接收消息
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
            notifier.onNext("z")
        }
    }
}

//通过对 UILabel 进行扩展，增加了一个fontSize 可绑定属性。
extension UILabel {
    //只读计算属性
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
