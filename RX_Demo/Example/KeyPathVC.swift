//
//  KeyPathVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/4.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

struct CBPerson {
    var name: String
    var age: Int
}

@dynamicMemberLookup
struct Lens<T> {
    let getter: () -> T
    let setter: (T) -> Void

    var value: T {
        get {
            return getter()
        }
        nonmutating set {
            setter(newValue)
        }
    }

//    subscript<U>(dynamicMember keyPath: WritableKeyPath<T, U>) -> Lens<U> {
//        return Lens<U>(
//            getter: { self.value[keyPath: keyPath] },
//            setter: { self.value[keyPath: keyPath] = $0 })
//    }

    subscript<U>(dynamicMember keyPath: WritableKeyPath<T, U>) -> U {
        return self.value[keyPath: keyPath]
    }
}

class KeyPathVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 类型为keypath<CBPerson,String>
        // let keyPath = \CBPerson.name
        let p = CBPerson(name: "Leon", age: 32)
        print(p[keyPath: \.name]) // 打印出 Leon
        print(p[keyPath: \CBPerson.name]) // 打印出 Leon

        let len = Lens<CBPerson> {
            CBPerson(name: "张三", age: 18)
        } setter: { p in
            print("  ==== \(p.name)")
        }

        print(" ====== \(len.name)")
    }
}
