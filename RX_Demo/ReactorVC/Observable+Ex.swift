//
//  Observable+Ex.swift
//  RX_Demo
//
//  Created by Weicb on 2021/9/20.
//  Copyright © 2021 fst. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit

extension ObservableType {
    func mapThenUntilChanged<Result>(_ transform: @escaping (Self.Element) throws -> Result) -> RxSwift.Observable<Result> where Result: Equatable {
        return map(transform).distinctUntilChanged()
    }
}
