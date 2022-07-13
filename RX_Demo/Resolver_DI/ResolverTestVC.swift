//
//  ResolverTestVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/4/5.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

class ResolverTestVC: UIViewController {
    let container = DIContainer.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        var buff: [CBPerson] = []

        let vc = CABasicAnimationVC()
        vc.view.backgroundColor = .red
//        for i in 0...1024 * 1024000 {
//            let p = CBPerson(name: "123", age: 1024 * 1024)
//            buff.append(p)
//        }

//        let s = MemoryLayout<CBPerson>.stride
//        let s1 = MemoryLayout<CBPerson>.size
//        let s2 = MemoryLayout<CBPerson>.alignment

//        print(" ===== \(s) =  \(s1) === \(s2)")

        view.backgroundColor = .white

        container.register(AnimalType.self) { rel in
            Dog(name: "狗")
        }
        let per = PersonSwinject()
        print(per.play())
    }
}
