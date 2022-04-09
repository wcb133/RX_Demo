//
//  PersonSwinject.swift
//  RX_Demo
//
//  Created by Weicb on 2022/4/9.
//  Copyright © 2022 fst. All rights reserved.
//

class PersonSwinject {
    @Inject var pet: AnimalType

    func play() -> String {
        return "I'm playing with \(pet.name). \(pet.sound())"
    }
}

protocol AnimalType {
    var name: String { get }
    func sound() -> String
}

class Cat: AnimalType {
    let name: String

    init(name: String) {
        self.name = name
    }

    func sound() -> String {
        return "Miao!"
    }
}

class Dog: AnimalType {
    let name: String

    init(name: String) {
        self.name = name
    }

    func sound() -> String {
        return "wangwang"
    }
}
