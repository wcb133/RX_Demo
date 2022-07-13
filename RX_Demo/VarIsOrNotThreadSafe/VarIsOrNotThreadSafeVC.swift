//
//  varIsOrNotThreadSafeVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/7/13.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

let obj = TestObj()

class VarIsOrNotThreadSafeVC: UIViewController {
    func test() {
        let x = obj
        print("test ==== \(x)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(" ======= viewDidLoad")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            for _ in 0...5 {
                DispatchQueue.global().async {
                    // 5秒之后才会打印TestObj里面init方法的日志，因为swift中static修饰的全局变量或者类变量都是lazy load，也就是第一次使用的时候才会初始化，并且这个初始化过程是原子化的https://blog.csdn.net/m0_55782613/article/details/122872899
                    let x = obj
                    print("viewDidLoad ==== \(x)")
                }
            }
        }
    }
}

class TestObj {
    init() {
        print(" ==  \(type(of: self)) init ==== \(Thread.current)")
    }

    /*
     可以看到全局变量在这个作用域内是先进行了retain操作，最后进行了release。

     对一个对象的retain和release操作，本身这个方法是原子操作的，所以不用担心这两个方法的线程安全问题。

     如果是全局可写的变量，当两个线程对这个对象进行改变的时候

     retain和release中间会出现穿插，导致业务上引用计数的变化不再安全。

     因此，对于全局变量写操作，必须进行加锁，保证retain和release在正确的逻辑中。
     */
}
