//
//  DITestSpec.swift
//  RX_DemoTests
//
//  Created by Weicb on 2022/4/8.
//  Copyright © 2022 fst. All rights reserved.
//

import Quick
import Nimble

@testable import RX_Demo

class DITestSpec: QuickSpec {
    override func spec() {
    
        describe("依赖注入测试") {
            
            beforeEach {
                let container = DIContainer.shared
                //设置为单元测试
                container.setupIsUnitTest(isUnitTest: true)
                
                container.register(AnimalType.self) { _ in
                    Cat(name: "Nimo")
                }
                
//                container.register(AnimalType.self,name: unitTestName) { _ in
//                    Cat(name: "Nimo")
//                }

            }
            
            it("test") {
                
                let person = PersonSwinject()
                expect(person.pet.name) == "猫"
            }
        }
    }
}
