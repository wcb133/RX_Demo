//
//  niceVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/5/2.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

@dynamicMemberLookup
public struct ChainWrapper<Subject> {
    fileprivate let subject: Subject
    var unWrapper: Subject {
        return subject
    }

    public init(_ subject: Subject) {
        self.subject = subject
    }

    public subscript<Value>(
        dynamicMember keyPath: WritableKeyPath<Subject, Value>
    ) -> ((Value) -> ChainWrapper<Subject>) {
        var subject = self.subject
        return { value in
            subject[keyPath: keyPath] = value
            return ChainWrapper(subject)
        }
    }
}

public protocol CNChainWrapperCompatible {
    associatedtype ChainWrapperBase

    static var bd: ChainWrapper<ChainWrapperBase>.Type { get }

    var bd: ChainWrapper<ChainWrapperBase> { get }
}

public extension CNChainWrapperCompatible {
    static var bd: ChainWrapper<Self>.Type {
        ChainWrapper<Self>.self
    }

    var bd: ChainWrapper<Self> {
        ChainWrapper(self)
    }
}

extension NSObject: CNChainWrapperCompatible {}
