//
//  SecondVC.swift
//  RX_Demo
//
//  Created by wcb on 2022/4/23.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    var titleString:String
    init(title:String){
        self.titleString = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let btn = UIButton().then {
        $0.setTitle("返回", for: .normal)
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
        
        btn.rx.tap.bind(to: rx.popViewController()).disposed(by: rx.disposeBag)
    }

}
