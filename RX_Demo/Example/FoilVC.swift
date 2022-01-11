//
//  FoilVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/4.
//  Copyright © 2022 fst. All rights reserved.
//

import Foil
import UIKit

final class AppSettings {
    static let shared = AppSettings()

    @WrappedDefault(key: "flagEnabled")
    var flagEnabled = false

    @WrappedDefault(key: "totalCount")
    var totalCount = 2

    @WrappedDefaultOptional(key: "timestamp")
    var timestamp: Date?
}


@dynamicMemberLookup
struct CBRxPerson {
  subscript(dynamicMember member: String) -> String {
    let properties = ["name": "Leon", "city": "Shanghai"]
    return properties[member, default: "null"]
  }

  subscript<T,U>(dynamicMember member: WritableKeyPath<T, U>) -> Int {
    return 32
  }
    
}


class FoilVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let p = CBRxPerson()
//        let age: Int = p.city // 32
        let name: String = p.name // Leon
        
        
    }
    
    func test() {
        print(" ========== \(String(describing: AppSettings.shared.timestamp))")
        AppSettings.shared.flagEnabled = true
        print(" ========== \(String(describing: AppSettings.shared.flagEnabled))")
    }
}


