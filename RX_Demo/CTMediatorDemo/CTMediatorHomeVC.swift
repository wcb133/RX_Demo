//
//  CTMediatorHomeVC.swift
//  RX_Demo
//
//  Created by wcb on 2022/4/23.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import CTMediator

class CTMediatorHomeVC: UIViewController {
    
    let btn = UIButton().then {
        $0.setTitle("测试跳转", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.equalTo(100)
            make.top.equalTo(120)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        
        if let vc = CTMediator.sharedInstance().getSecondVC(title: "二级界面") {
            btn.rx.tap.bind(to: rx.pushViewController(vc)).disposed(by: rx.disposeBag)
        }
        
        
    }
    
}
