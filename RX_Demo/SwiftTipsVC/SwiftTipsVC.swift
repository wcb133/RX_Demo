//
//  SwiftTipsVC.swift
//  RX_Demo
//
//  Created by wcb on 2022/1/13.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import SnapKit
import Differentiator
import RxSwift

enum ExceptionError: Error {
    case httpCode(Int)
}

func any<T: Equatable>(of values: T...) -> EquatableValueSequence<T> {
    return EquatableValueSequence(values: values)
}

struct EquatableValueSequence<T: Equatable> {
    fileprivate let values: [T]
    static func == (lhs: EquatableValueSequence<T>, rhs: T) -> Bool {
        return lhs.values.contains(rhs)
    }

    static func == (lhs: T, rhs: EquatableValueSequence<T>) -> Bool {
        return rhs == lhs
    }
}

// ExpressibleByStringLiteral:通过字符串构造对象
extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            fatalError("Bad string, failed to create url from: \(value)")
        }
        self = url
    }
}

class SwiftTipsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let nums = [12, 5, 6, 4, 10, 30]

        let isHave = nums.contains(where: { $0 == 5 })

        // 当出现小于9的元素时，返回前面的所有元素
        let bigNums = nums.prefix(while: { $0 >= 9 })
        // 当出现大于9的元素时，返回后面的所有元素
        let smallNums = nums.drop(while: { $0 >= 9 })

        print(" ====== \(isHave) == \(bigNums) == \(smallNums)")

        // 字符串转化数组
        let line = "I don't want realism. I want magic!"

        let wordArr = line.split(whereSeparator: { $0 == " " })
        print(" =========== \(wordArr)")
        // ["I", "don\'t", "want", "realism.", "I", "want", "magic!"]

        // 数组排序
        let sortNums = nums.sorted(by: <)
        print("排序 =========== \(sortNums)")

        // 字符串判空
        let blankString: String? = nil
        print(" ======= \("".isBlank) === \("  ".isBlank) ==== \(blankString.isBlank)")

        // or判断改进
        orTips()
        // 添加多个子view
        add()

        // try catch的时候做条件判断
        do {
            try throwError()
        } catch let ExceptionError.httpCode(httpCode) where httpCode >= 500 {
            print("server error")
        } catch {
            print("other error")
        }

        // switch语句做限定条件
        let student: (name: String, score: Int) = ("小明", 59)
        switch student {
        case let (_, score) where score < 60:
            print("不及格")
        default:
            print("及格")
        }

        // 实现了ExpressibleBy协议集的对象，可以通过像字符串、整型、浮点型、数组、字典等直接实例化对象
        // 字符串构造URL
        let url1 = URL(string: "https://github.com/DarielChen/iOSTips")!
        // 使用ExpressibleByStringLiteral后，但是可读性变差了(String类默认实现了ExpressibleByStringLiteral)
        let url2: URL = "https://github.com/DarielChen/iOSTips"
    }

    func throwError() throws {
        throw ExceptionError.httpCode(500)
    }

    /// 或语句改进
    func orTips() {
        // 原始方式
        let string = "One"
        if string == "One" || string == "Two" || string == "Three" {
            print(" ======= 匹配到了")
        }

        // 改进1
        if ["One", "Two", "Three"].contains(where: { $0 == string }) {
            print(" ======= 匹配到了")
        }

        // 改进二
        if string == any(of: "One", "Two", "Three") {
            print("最终方式 ======== 匹配到了")
        }
    }

    /// 可变参数函数
    func add() {
        let lab = UILabel()
        let lab2 = UILabel()
        let lab3 = UILabel()
        view.add(subViews: lab, lab2, lab3)
    }
}

extension UIView {
    // 同时添加多个子控件
    func add(subViews: UIView...) {
        subViews.forEach(addSubview)
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy { $0.isWhitespace }
    }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}
