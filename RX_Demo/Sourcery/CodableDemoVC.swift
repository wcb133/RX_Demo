//
//  CodableDemo.swift
//  RX_Demo
//
//  Created by Weicb on 2022/4/30.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation

protocol AutoCodable: Codable {}

struct CBSuperPerson: AutoCodable {
    var id: Int
    var name: String
    var age: Int
    var isMale: Bool
    var description: String = "person"
    var isSuper: Bool? // 铁定不会进行编码

//    enum CodingKeys: String, CodingKey {
//        // 不在这个枚举值内的key，也不会进行编码,如果来自服务器的数据没对应的key，会崩溃，例如没有“姓名”字段，会崩溃
//        case id = "身份证号"
//        case name = "姓名"
//        case age = "年龄"
//        case isMale
//
//    }
}

// MARK: - CBSuperPerson Codable

extension CBSuperPerson {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age
        case isMale
        case description
        case isSuper
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        if let r = try? container.decode(Bool.self, forKey: .isMale) {
            isMale = r
        } else if let r = try? container.decode(Int.self, forKey: .isMale) {
            isMale = (r == 0 ? false : true)
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.isMale], debugDescription: "Expected to decode Bool")
            throw DecodingError.typeMismatch(Bool.self, context)
        }
        description = try container.decode(String.self, forKey: .description)
//        isSuper = try container.decode(Bool?.self, forKey: .isSuper)
    }
}

class CodableDemoVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let tim = CBSuperPerson(id: 3, name: "tim", age: 10, isMale: true, description: "")
        if let timData = try? JSONEncoder().encode(tim) {
            print(String(data: timData, encoding: .utf8)!)
        }

        let jsonString = """
        {
            "id": 2,
            "name": "lucy",
            "age": 11,
            "isMale": false,
            "description": "描述"
        }
        """
        if let json = jsonString.data(using: .utf8) {
            let lucy = try? JSONDecoder().decode(CBSuperPerson.self, from: json)
            print(lucy!)
        }
    }
}
