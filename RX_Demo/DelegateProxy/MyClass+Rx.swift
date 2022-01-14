//
//  rxMyClass.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/14.
//  Copyright © 2021 fst. All rights reserved.
//
import RxSwift
import RxCocoa

extension Reactive where Base: MyClass {
    var delegate: DelegateProxy<MyClass, MyDelegate> {
        return RxMyDelegateProxy.proxy(for: base)
    }

    var nums: Observable<Int> {
        return RxMyDelegateProxy.proxy(for: base).nums.asObservable()
    }

    // 非必须实现的协议
    var strs: Observable<String> {
        return delegate.methodInvoked(#selector(MyDelegate.printStr(str:))).map {
            return $0[0] as! String
        }
    }
}
