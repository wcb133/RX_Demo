//
//  RxMyDelegateProxy.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/14.
//  Copyright © 2021 fst. All rights reserved.
//

import RxSwift
import RxCocoa

public typealias RxGetName = (Int) -> (String?)

class RxMyDelegateProxy: DelegateProxy<MyClass, MyDelegate>, DelegateProxyType, MyDelegate {
    public var getNameClosure: RxGetName?

    init(my: MyClass) {
        super.init(parentObject: my, delegateProxy: RxMyDelegateProxy.self)
    }

    static func registerKnownImplementations() {
        register { parent -> RxMyDelegateProxy in
            RxMyDelegateProxy(my: parent)
        }
    }

    static func currentDelegate(for object: MyClass) -> MyDelegate? {
        return object.delegate
    }

    static func setCurrentDelegate(_ delegate: MyDelegate?, to object: MyClass) {
        object.delegate = delegate
    }

    override func setForwardToDelegate(_ delegate: DelegateProxy<MyClass, MyDelegate>.Delegate?, retainDelegate: Bool) {
        super.setForwardToDelegate(delegate, retainDelegate: true)
    }

    // 必须实现的协议可用这种方式
    internal lazy var nums = PublishSubject<Int>()

    func printNum(num: Int) {
        _forwardToDelegate?.printNum(num: num)
        nums.onNext(num)
    }

    // 这种方式实现的代理hook，后面代理就不会回调这个方法了
    func getName(age: Int) -> String {
        return getNameClosure?(age) ?? ""
    }

    deinit {
        self.nums.onCompleted()
    }
}
