//
//  ResolverTestVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/4/5.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import Resolver

extension Resolver: ResolverRegistering {
    // 这个方式是首次调用Resolver.resolve的时候会执行一次，只会执行一次
    public static func registerAllServices() {
        register { resolver, args -> XYZSessionService in
            print(" ===== 带参数的\(args)")
            return XYZSessionService()
        }
        .implements(XYZSessionProtocol.self) // 指定register中的返回对象要实现的协议
//        register { XYZSessionService() }//重复注册的话，会替换掉，因为内部保存是以XYZSessionService的对象id为key
        register { XYZService(optional()) }
    }
}

protocol XYZSessionProtocol {
    var id: UUID { get }
}

class XYZSessionService: XYZSessionProtocol {
    let id = UUID()
    var name: String = "XYZSessionService"
}

class XYZService {
    static var counter = 0
    let count: Int
    let session: XYZSessionService?
    var name: String { return "XYZService" }
    init(_ session: XYZSessionService?) {
        self.session = session
        XYZService.counter += 1
        count = XYZService.counter
    }
}

class ResolverTestVC: UIViewController {
    var service: XYZService?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Resolver.register { resolver, args -> XYZSessionService in
            print("替换带 ===== 带参数的\(args)")
            return XYZSessionService()
        }
        let service = Resolver.resolve(XYZSessionService.self, args: "参数")

        let service2 = Resolver.resolve(XYZSessionService.self, args: "参数")
    }
}
