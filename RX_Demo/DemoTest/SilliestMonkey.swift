//
//  SilliestMonkey.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

public func silliest(monkeys: [Monkey]) -> [Monkey] {
    return monkeys.filter { $0.silliness == .VerySilly || $0.silliness == .ExtremelySilly }
}

public func monkeyContains<T: Equatable>(array: [T], object: T?) -> Bool {
    for temp in array {
        if temp == object {
            return true
        }
    }

    return false
}
