//
//  SubjectsVC.swift
//  RX_Demo
//
//  Created by fst on 2019/12/16.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        subject()
//        behaviorSubject()
        behaviorRelay()
    }
    
    func subject()  {
        let disposeBag = DisposeBag()
         
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
         
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        subject.onNext("111")
         
        //第1次订阅subject
        subject.subscribe(onNext: { string in
            print("第1次订阅：", string)
        }, onCompleted:{
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)
         
        //当前有1个订阅，则该信息会输出到控制台
        subject.onNext("222")
         
        //第2次订阅subject
        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：onCompleted")
        }).disposed(by: disposeBag)
         
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
         
        //让subject结束
        subject.onCompleted()
         
        //subject完成后会发出.next事件了。
        subject.onNext("444")
         
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
    }
    
    func behaviorSubject() {
        let disposeBag = DisposeBag()
        //创建一个BehaviorSubject
        let subject = BehaviorSubject(value: "111")
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disposeBag)
        //发送next事件
        subject.onNext("222")
        //发送error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
        //第2次订阅subject，在订阅的时候会立刻收到上次发出的event
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
    }
    /* ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
    比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个.next 的 event。
    如果一个 subscriber 订阅已经结束的 ReplaySubject，除了会收到缓存的 .next 的 event外，还会收到那个终结的 .error 或者 .complete 的event。
    */
    func replaySubject() {
        let disposeBag = DisposeBag()
         
        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 2)
         
        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
         
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disposeBag)
         
        //再发送1个next事件
        subject.onNext("444")
         
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
         
        //让subject结束
        subject.onCompleted()
         
        //第3次订阅subject
        subject.subscribe { event in
            print("第3次订阅：", event)
        }.disposed(by: disposeBag)
    }
    /* behaviorRelay是behaviorSubject的封装， 有一个 value 属性，我们改变这个 value 属性的值就相当于调用一般 Subjects 的 onNext() 方法，而这个最新的 onNext() 的值就被保存在 value 属性里了，直到我们再次修改它。
    */
    func behaviorRelay()  {
        let disposeBag = DisposeBag()
        //创建一个初始值为111的Variable
        let variable = BehaviorRelay(value: "111")
        //修改value值
        variable.accept("222")
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
        }.disposed(by: disposeBag)
        //修改value值
        variable.accept("333")
        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
        }.disposed(by: disposeBag)
        //修改value值
        variable.accept("444")
    }
}
