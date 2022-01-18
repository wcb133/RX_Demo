//
//  SilliestMonkeyTests.swift
//  RX_DemoTests
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

import XCTest
import RX_Demo
import Nimble

class SilliestMonkeyTests: XCTestCase {
    func testSilliest() {
        // Arrange:
        let kiki = Monkey(name: "Kiki", silliness: .ExtremelySilly)
        let carl = Monkey(name: "Carl", silliness: .NotSilly)
        let jane = Monkey(name: "Jane", silliness: .VerySilly)
        
        // Act
        let sillyMonkeys = silliest(monkeys: [kiki,carl,jane])
        
        // Assert
//        let isContains = monkeyContains(array: sillyMonkeys, object: kiki)
//        XCTAssertTrue(isContains)
//        XCTAssertTrue(isContains, "Expected sillyMonkeys to contain 'Kiki'")
        
        // 使用Nimble
        expect(sillyMonkeys).toEventually(contain(kiki))
        expect(sillyMonkeys).to(contain(kiki))
        
    }
}
