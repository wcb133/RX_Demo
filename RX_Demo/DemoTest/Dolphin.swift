//
//  Dolphin.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

public struct Click {
    public var isLoud = true
    public var hasHighFrequency = true

    public func count() -> Int {
        return 1
    }
}

public protocol EdibleProcotol {
    var edible: Bool { get }
    var edibleDecs: String { get }
}

public extension EdibleProcotol {
    var edible: Bool {
        return true
    }

    var edibleDecs: String {
        "可以食用"
    }
}

public class Dolphin {
    public var isFriendly = true
    public var isSmart = true
    public var isHappy = false

    public init() {}

    public init(happy: Bool) {
        isHappy = happy
    }

    public func click() -> Click {
        return Click()
    }

    public func eat(food: EdibleProcotol) {
        isHappy = food.edible
    }
}
