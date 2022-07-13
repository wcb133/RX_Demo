//
//  blockVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/5/5.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
class Car {
    var name: String = ""

    deinit {
        print(" ====== 释放")
    }
}

class blockVC: UIViewController {
    var handlBlock: (String) -> Void = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        test1()
//        test2()
//        test3()
//        test4()
//        test5()
//        test6()
//        test7()
        test8()
//        testRetain()
    }

    func test1() { // 打印"大D"，捕获了car
        var car = "大D"

        let block = { [car] in
            print("我开\(car)")
        }
        car = "雅迪"
        block()
    }

    func test2() { // 打印"雅迪"，未捕获car，使用的任然是全局的car
        var car = "大D"

        let block = {
            print("我开\(car)")
        }
        car = "雅迪"
        block()
    }

    func test3() { // 打印雅迪，car虽然被捕获了，但是name的指向被修改了
        let car = Car()
        car.name = "大D"
        let block = { [car] in
            print("我开\(car.name)")
        }
        car.name = "雅迪"
        block()
    }

    func test4() { // 打印的是大D，闭包里面捕获的是之前的car,这里的前后两个car对象，都是在函数执行完之后才释放,
        var car = Car()
        car.name = "大D"
        let block = { [car] in // 相当于临时建了一个同名变量来存储外部的car
            print("我开\(car.name)")
        }
        car = Car()
        car.name = "雅迪"
        block()
    }

    func test5() { // 打印雅迪，闭包内的car指向最新的
        var car = Car()
        car.name = "大D"
        let block = {
            print("我开\(car.name)")
        }
        car = Car()
        car.name = "雅迪"
        block()
        /*
          控制台输出：
          ====== 释放
         我开雅迪
          ====== 释放
          */
    }

    func test6() { // 打印nil，car已被释放
        var car = Car()
        car.name = "大D"
        let block = { [weak car] in
            print("我开\(car?.name)")
        }
        car = Car()
        car.name = "雅迪"
        block()
    }

    func test7() { // 打印nil，car已被释放,所以这里会奔溃，野指针;unowned和weak都是只针对引用类型，值类型不可用
        var car = Car()
        car.name = "大D"
        let block = { [unowned car] in
            print("我开\(car.name)")
        }
        car = Car() // 原来的car会被释放
        car.name = "雅迪"
        block()
    }

    func test8() {
        var car = Car()
        car.name = "大D"
        let block = {
            print("我开\(car.name)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            block()
        }
    }

    func testRetain() {
        // 这个捕获是捕获闭包之前的self的值，但是这个方式还是会循环引用，控制器无法释放
//        self.handlBlock = { [self] test in
//            print("引用测试 ====== \(self)")
//        }

        // 这个捕获是捕获闭包之前的self的值，并且如果之前的self被释放了，这个self会被置为nil，这个不会循环引用，控制器可以被释放
//        self.handlBlock = { [weak self] test in
//            print("引用测试 ====== \(self)")
//        }
        handlBlock("adfsa")
    }

    deinit {
        print(" 控制器释放 ===== \(self)")
    }
}
