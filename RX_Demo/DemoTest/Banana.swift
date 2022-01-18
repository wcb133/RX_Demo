//
//  Banana.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation

public class Banana {
    private var isPeeled = false

    public init() {}

    public func peel() {
        isPeeled = true
    }

    public var isEdible: Bool {
        return isPeeled
    }
}
