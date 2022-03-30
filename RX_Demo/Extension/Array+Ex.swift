//
//  Array+Ex.swift
//  RX_Demo
//
//  Created by Weicb on 2022/2/21.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

extension Array {
    // 防止数组越界
    subscript(safe index: Int) -> Element? {
        if count > index {
            print(" -===== ")
            return self[index]
        }
        return nil
    }
}
