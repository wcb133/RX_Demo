//
//  BananaTests.swift
//  RX_DemoTests
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

import XCTest
import RX_Demo

class BananaTests: XCTestCase {
    
    func testPeel_makewThenBananaEdible() {
        // Arrange
        let ba = Banana()
        // Act:
        ba.peel()
        // Assert:
        XCTAssertTrue(ba.isEdible)
    }
    
}
