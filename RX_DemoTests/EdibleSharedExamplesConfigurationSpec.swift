//
//  EdibleSharedExamplesConfigurationSpec.swift
//  RX_DemoTests
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

import Quick
import Nimble
import RX_Demo

class EdibleSharedExamplesConfiguration: QuickConfiguration {
    
    override class func configure(_ configuration: Configuration) {
        
        sharedExamples("something edible") { (sharedExampleContext: @escaping SharedExampleContext) in
            it("makes dolphins happy") {
                let dolphin = Dolphin(happy: false)
                let edible  = sharedExampleContext()["edible"] as? EdibleProcotol
                expect(edible).notTo(beNil())
                dolphin.eat(food: edible!)
                expect(dolphin.isHappy).to(beTruthy())
            }
        }
    }
    
}

class EdibleSharedExamplesConfigurationSpec: QuickSpec {
  override func spec() {
      
      //不传参数的共享用例
      sharedExamples("everything under the sea") {
          it("测试isLoud属性") {
              let click = Dolphin().click()
              expect(click.isLoud).to(beTruthy())
          }
      }
      
      itBehavesLike("everything under the sea")
  }
      
//    var mackerel: Mackerel!
//    beforeEach {
//      mackerel = Mackerel()
//    }
//      //这里面的字符串要和共享测试的字符串一致
//      itBehavesLike("something edible") {
//          ["edible": mackerel as Any]
//      }
//  }
}

class MackerelSpec: QuickSpec {
  override func spec() {
    var mackerel: Mackerel!
    beforeEach {
      mackerel = Mackerel()
    }
      //这里面的字符串要和共享测试的字符串一致,如果共享用例没通过，报错会跑来这里，没具体指向内部错误，这共享用例视乎不太好
      itBehavesLike("something edible") {
          ["edible": mackerel as Any]
      }
  }
}

class CodSpec: QuickSpec {
  override func spec() {
    var cod: Cod!
    beforeEach {
      cod = Cod()
    }

      itBehavesLike("something edible") { ["edible": cod as Any] }
  }
}
