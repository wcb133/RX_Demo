//
//  Reusable.swift
//  RX_Demo
//
//  Created by Weicb on 2021/9/20.
//  Copyright © 2021 fst. All rights reserved.
//

protocol Reusable {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UIViewController: Reusable {}
