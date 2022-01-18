//
//  DolphinSpec.swift
//  RX_DemoTests
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import Nimble
import RX_Demo
import Quick

class DolphinSpec: QuickSpec {
    
    override func spec() {
        
//        beforeEach { exampleMetadata in
//          print("当前运行的例子 \(exampleMetadata.exampleIndex) is about to be run.")
//        }
//
//        afterEach { exampleMetadata in
//          print("当前运行的例子个数 \(exampleMetadata.exampleIndex) has run.")
//        }
        
        beforeSuite {
         //所有例子运行前，比如可加载数据库
        }

        afterSuite {
          // 所有例子运行后，比如卸载数据库
        }
        
        
        
        // it用于描述测试的方法名
        it("is friendly") {
            expect(Dolphin().isFriendly).to(beTruthy())
        }
        
        // describe用于描述类和方法
        describe("dolphin测试") {
            var dolphin: Dolphin!
            // 该闭包内所有例子运行之前
            beforeEach {
                dolphin = Dolphin()
            }
            
            afterEach {
                dolphin = nil
            }
            
            //可以嵌套
            describe("判断isLoud属性") {
                //一定要有个it包裹着，否则测试不通过的时候，直接崩溃了
                it("测试isLoud属性") {
                    let click = dolphin.click()
                    expect(click.isLoud).to(beTruthy())
                }
                
                it("has a high frequency") {
                    let click = dolphin.click()
                    expect(click.hasHighFrequency).to(beTruthy())
                }
            }
        }
        
        // 使用 context 指定条件的行为
        describe("测试context") {
              var dolphin: Dolphin!
              beforeEach { dolphin = Dolphin() }

              describe("its click") {
                context("when the dolphin is not near anything interesting") {
                  it("is only emitted once") {
                    expect(dolphin.click().count).to(equal(1))
                  }
                }

                context("when the dolphin is near something interesting") {
//                  beforeEach {
//                    let ship = SunkenShip()
//                    Jamaica.dolphinCove.add(ship)
//                    Jamaica.dolphinCove.add(dolphin)
//                  }

//                  it("is emitted three times") {
//                    expect(dolphin.click().count).to(equal(3))
//                  }
                }
              }
            }
        
        
    }
    
}
