//
//  Monkey.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

public enum MonkeyIntelligent {
    case ExtremelySilly
    case NotSilly
    case VerySilly
}

public class Monkey: Equatable {
    var name: String?
    var silliness: MonkeyIntelligent?

    public init(name: String, silliness: MonkeyIntelligent) {
        self.name = name
        self.silliness = silliness
    }

    // 遵循Equatable协议,必须实现此方法
    public static func == (lhs: Monkey, rhs: Monkey) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
