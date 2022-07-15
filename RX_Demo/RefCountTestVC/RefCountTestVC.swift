//
//  RefCountTestVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/7/15.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

class Swagger {
    var name = ""
    var age = 10
    init() {
        print(" ===== \(name) ==\(age)")
    }
}

class RefCountTestVC: UIViewController {
    var sg = Swagger()
    var sgOne = Swagger()
    override func viewDidLoad() {
        super.viewDidLoad()
        let sg = Swagger() // 引用计数在下标33(第34位)的位置，创建对象的时候，引用计数为0
        let ptr = Unmanaged.passUnretained(sg).toOpaque()
        print("地址 ===== \(ptr)") // x/4gx  地址，可看出创建对象的时候，引用计数为0
        var sg1 = sg // 引用计数位加1，变成16进制就是0x0000000200000003
        var sg2 = sg // 引用计数位加1，变成16进制就是0x0000000400000003
        self.sg = sg
        sgOne = sg
    }
}
