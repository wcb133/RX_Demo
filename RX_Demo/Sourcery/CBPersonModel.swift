//
//  CBPersonModel.swift
//  RX_Demo
//
//  Created by Weicb on 2022/4/29.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation
import HandyJSON

protocol AutoEquatable {}

protocol AutoHandyJSONMapper {}

protocol AutoHashable {}

protocol DictionaryConvertible {}

extension Int { var value: Int { return self } }
extension String { var value: String { return self } }
extension Bool { var value: Bool { return self } }
extension Double { var value: Double { return self } }
extension Float { var value: Float { return self } }

class BaseModel: NSObject, HandyJSON {
    override required init() {}

    func willStartMapping() {}

    func didFinishMapping() {}

    func mapping(mapper: HelpingMapper) {}
}

class CBPersonModel: BaseModel {
    // 测试
    // sourcery: key = "nameString"
    var name: String = ""
    var age: Int = 0
}

extension CBPersonModel: AutoEquatable, AutoHandyJSONMapper, DictionaryConvertible, AutoHashable {}
