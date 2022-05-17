//
//  DIContainer.swift
//  DIContainer
//
//  Created by wcb on 2021/05/24.
//

import Foundation
import Swinject

fileprivate let isUnitTestName = "isUnitTest"
let unitTestName = "unitTest"

@propertyWrapper
final class Inject<T> {
    // 这里用let，被包裹的属性就是只读属性了，不能再次赋值
    let wrappedValue: T
    init() {
        let isUnitTest: Bool = DIContainer.shared.resolve(name: isUnitTestName)
        wrappedValue = DIContainer.shared.resolve(name: isUnitTest ? unitTestName : nil)
    }
}

final class DIContainer {
    static let shared = DIContainer()
    private init() {
        setupIsUnitTest(isUnitTest: false)
        configureContainer()
    }

    private let _container = Container()

    private func configureContainer() {
        _container.register(AnimalType.self) { _ in
            Cat(name: "Nimo")
        }

        _container.register(PersonSwinject.self) { _ in
            PersonSwinject()
        }
    }

    /// 设置是否是单元测试
    /// - Parameter isUnitTest: 是否是单元测试
    func setupIsUnitTest(isUnitTest: Bool = false) {
        _container.register(Bool.self, name: isUnitTestName) { _ in
            isUnitTest
        }
    }

    @discardableResult
    public func register<Service>(
        _ serviceType: Service.Type,
        name: String? = nil,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service> {
        return _container.register(serviceType, name: name, factory: factory)
    }

    func resolve<T>(name: String? = nil) -> T {
        guard let inject = _container.resolve(T.self, name: name) else {
            fatalError("未注册对应类 ======  \(T.self) Error")
        }
        return inject
    }
}
