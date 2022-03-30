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
        print(" ====== ")
        isPeeled = true
    }

    public var isEdible: Bool {
        print(" ===== 12")
        return isPeeled
    }
}
