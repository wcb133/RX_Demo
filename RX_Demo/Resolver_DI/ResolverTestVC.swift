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
        view.backgroundColor = .white

        container.register(AnimalType.self) { _ in
            Dog(name: "狗")
        }
        let per = PersonSwinject()
        print(per.play())
    }
}
