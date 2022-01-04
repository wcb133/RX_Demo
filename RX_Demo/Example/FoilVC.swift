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
    var flagEnabled = true

    @WrappedDefault(key: "totalCount")
    var totalCount = 0

    @WrappedDefaultOptional(key: "timestamp")
    var timestamp: Date?
}

class FoilVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(" ========== \(String(describing: AppSettings.shared.timestamp))")
    }
}
