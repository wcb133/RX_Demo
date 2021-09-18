//
//  TransformingVC.swift
//  RX_Demo
//
//  Created by fst on 2019/12/17.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TransformingVC: UIViewController {
     let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        buferf()
        window()
//        map()
//        flatmap()
//        flatMapLatest()
//        scan()
//        groupBy()
        
        var count = 1
        //重试操作符
        Observable.just(1).filterMap({ num in
            return num == 1 ? .ignore:.map(num * 2)
        }).flatMap { i in
            return Observable<Int>.create { ob in
                count += 1
                if count > 3 {
                    ob.onNext(5)
                }else{
                    print("错误重进 ========= \(count)")
                    ob.onError(NSError(domain: "错误", code: 200, userInfo: [:]))
                }
                return Disposables.create()
            }
        }.retry(.exponentialDelayed(maxCount: 5, initial: 1.0, multiplier: 1.0)).subscribe(onNext:{ num in
            print(" ========= \(num)")
        }).disposed(by: disposeBag)
        
        
        func someAsynchronousService(arg1: String, arg2: Int, completionHandler:(String) -> Void) {
            // a service that asynchronously calls
            // the given completionHandler
            completionHandler("测试")
        }

        
        //
//        Observable.just(1).catchErrorJustComplete().subscribe(onNExt:{
//
//        }).disposed(by: disposeBag)
        
        
    }
    //序列分离
    func groupBy() {
        //将奇数偶数分成两组
        Observable<Int>.of(0, 1, 2, 3, 4, 5)
            .groupBy(keySelector: { (element) -> String in
                return element % 2 == 0 ? "偶数" : "基数"
            })
            .subscribe { (event) in
                switch event {
                case .next(let group):
                    group.asObservable().subscribe({ (event) in
                        print("key：\(group.key)    event：\(event)")
                    })
                        .disposed(by: self.disposeBag)
                default:
                    print("")
                }
            }
        .disposed(by: disposeBag)
    }
    
    func scan()  {
        Observable.of(1, 2, 3, 4, 5)
            .scan(0) { acum, elem in
                acum + elem
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func flatMapLatest()  {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = BehaviorRelay(value: subject1)
         
        variable.asObservable()
            .flatMapLatest { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext("B")
        variable.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")

    }
    
    //flatmap的降维作用，当 Observable 的元素本生拥有其他的 Observable 时，我们可以将所有子 Observables 的元素发送出来
    func flatmap(){
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = BehaviorRelay(value: subject1)
         
        variable.asObservable()
            .flatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext("B")
        variable.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")//注意这里是subject1发出event，但是上面的订阅依旧能订阅到
    }
    
    func map() {
        Observable.of(1, 2, 3)
        .map { $0 * 10}
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    }
    
    func window() {
//        let subject = PublishSubject<String>()
//        //每3个元素作为一个子Observable发出。
//        subject
//            .window(timeSpan: RxTimeInterval.seconds(5), count: 3, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [weak self]  in
//                print("subscribe: \($0)")
//                $0.asObservable()
//                    .subscribe(onNext: { print($0) })
//                    .disposed(by: self!.disposeBag)
//            })
//            .disposed(by: disposeBag)
//        subject.onNext("a")
//        subject.onNext("b")
//        subject.onNext("c")
//
//        subject.onNext("1")
//        subject.onNext("2")
//        subject.onNext("3")
        
//        let array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]
//        Observable.from(array).window(timeSpan: RxTimeInterval.seconds(0), count: 3, scheduler: MainScheduler.instance).flatMap { ob -> Observable<Int> in
//            print(" ========== \(ob)")
//            return ob.flatMap { ti -> Single<Int> in
//                self.testDelay(str: ti)
//            }
//        }.subscribe(onNext:{ ti in
//            print("时间 ========= \(ti)")
//        })
        

    }
    
    func testDelay(str:Int) -> Single<Int> {
        return .create { ob in
            ob(.success(str))
            print( "间隔==========\(str)" )
            return Disposables.create()
        }.delay(RxTimeInterval.seconds(5 + str * 2), scheduler: MainScheduler.instance)
    }
    
    func buferf(){
//        let subject = PublishSubject<String>()
//       //每缓存3个元素则组合起来一起发出。
//       //如果1秒钟内不够3个也会发出（有几个发几个，一个都没有发空数组 []）
//       subject
//        .buffer(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
//           .subscribe(onNext: { print($0) })
//           .disposed(by: disposeBag)
//       subject.onNext("a")
//       subject.onNext("b")
////        subject.delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance).onNext("c")
//
//       subject.onNext("1")
//       subject.onNext("2")
//       subject.onNext("3")
        
        let array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]
        Observable.from(array).buffer(timeSpan: RxTimeInterval.seconds(0), count: 3, scheduler: MainScheduler.instance).concatMap{ arr in
            return Observable.from(arr).flatMap { ti in
                self.testDelay(str: ti)
            }
        }.subscribe(onNext:{ ti in
            print("时间 ========= \(ti)")
        })
    }
}
