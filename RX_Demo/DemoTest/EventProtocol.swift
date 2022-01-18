//
//  EventProtocol.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

public protocol EventProtocol {
    var name: String { get set }
    var startDate: NSDate { get set }
    var endDate: NSDate { get set }
}
