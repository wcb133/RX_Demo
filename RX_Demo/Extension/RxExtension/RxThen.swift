//
//  RxThen.swift
//  RX_Demo
//
//  Created by wcb on 2022/4/23.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

public extension ObservableType {

    func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<Element> {
        return map {
            try closure()
            return $0
        }
    }
}

public extension PrimitiveSequence where Trait == SingleTrait {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> PrimitiveSequence<Trait, Element> {
        return map {
            closure()
            return $0
        }
    }
}

public extension SharedSequence where SharingStrategy == DriverSharingStrategy  {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<SharingStrategy, Element> {
        return map {
            closure()
            return $0
        }
    }
}
