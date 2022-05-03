//
//  niceVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/5/2.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

@dynamicMemberLookup
public struct ChainWrapper<T> {
    public let object: T

    public init(_ object: T) {
        self.object = object
    }

    public subscript<E>(
        dynamicMember keyPath: WritableKeyPath<T, E>
    ) -> ((E) -> ChainWrapper<T>) {
        var subject = self.object
        return { value in
            subject[keyPath: keyPath] = value
            return self
        }
    }
}

public protocol ChainWrapperCompatible {
    associatedtype ChainWrapperBase

    static var ch: ChainWrapper<ChainWrapperBase>.Type { get }

    var ch: ChainWrapper<ChainWrapperBase> { get }
}

public extension ChainWrapperCompatible {
    static var ch: ChainWrapper<Self>.Type {
        ChainWrapper<Self>.self
    }

    var ch: ChainWrapper<Self> {
        ChainWrapper(self)
    }
}

extension NSObject: ChainWrapperCompatible {}
