//
//  MyClass.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/14.
//  Copyright © 2021 fst. All rights reserved.
//

@objc public protocol MyDelegate {
    func printNum(num: Int)
    @objc optional func printStr(str: String)
}

class MyClass: NSObject {
    public weak var delegate: MyDelegate?
    var timer: Timer?
    override init() {}
    // 模仿调用代理
    func start() {
        timer = .init(timeInterval: 1, repeats: true, block: { _ in
            self.delegate?.printNum(num: 1)
            self.delegate?.printStr?(str: "这是字符串")
        })
        RunLoop.current.add(timer!, forMode: .default)
        timer?.fire()
    }

    func stop() {
        timer?.invalidate()
    }
}
