//
//  RxUIVIewController.swift
//  RX_Demo
//
//  Created by wcb on 2022/4/23.
//  Copyright © 2022 fst. All rights reserved.
//

import RxSwift

public extension Reactive where Base: UIViewController {
    
    /// Push view controller
    /// Example:
    ///
    ///     pushButton.rx.tap
    ///         .bind(to: rx.pushViewController(vc, animated: true))
    ///         .disposed(by: disposeBag)
    ///
    func pushViewController(_ viewController: @escaping @autoclosure () -> UIViewController,
                            animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewController(viewController(), animated: animated)
        }
    }
    
    func popViewController(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popToRootViewController(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func present(_ viewController: @escaping @autoclosure () -> UIViewController,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.present(viewController(), animated: animated, completion: completion)
        }
    }
    
    func dismiss(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.dismiss(animated: animated, completion: nil)
        }
    }
}
