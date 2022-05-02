//
//  FoilVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/4.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

// 需要注意的是如果声明在类上，那么他的子类也会具有动态查找成员的能力。
@dynamicMemberLookup
struct CBRxPerson {
    let age = 0

    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Leon", "city": "Shanghai"]
        return properties[member, default: "null"]
    }
}

@dynamicMemberLookup
struct CBDynamicPerson {
    struct Info {
        var name: String
    }

    var info: Info

    subscript<E>(dynamicMember keyPath: WritableKeyPath<Info, E>) -> E {
        get {
            return info[keyPath: keyPath] // 由info的类型，反向推断出传入的参数的keyPath类型
        }
        set {
            info[keyPath: keyPath] = newValue
        }
    }
}

class DynamicMemberLookupVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let p = CBRxPerson()
        let name = p.city // Leon

        var p2 = CBDynamicPerson(info: CBDynamicPerson.Info(name: "小明"))
        //  p2.name 等价于 p2[keyPath: \.name]，并且p2.name的时候，编译器还提示
        print("前面 ====== \(p2.name)")
        p2.name = "张三"
        print("后面 ====== \(p2[keyPath: \.name])")
    }
}
