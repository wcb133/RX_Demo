//
//  Asynchronous.swift
//  RX_DemoTests
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

import Quick
import Nimble

class Asynchronous: QuickSpec {
    override func spec() {
        it("异步测试") {
            // Swift
            var ocean:Array = []
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                ocean.append("dolphins")
                ocean.append("whales")
            }
            //异步测试使用toEventually 或者是 toEventuallyNot,默认是1秒
            expect(ocean).toEventually(contain("dolphins", "whales"),timeout: .seconds(3))
        }
    }
}
