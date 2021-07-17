//
//  RootVC.swift
//  RX_Demo
//
//  Created by wcb on 2021/7/17.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit

class RootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let lab = UILabel()
        lab.text = "点击空白处进入"
        lab.textColor = .red
        lab.frame = CGRect(x: 50, y: 100, width: 200, height: 80)
        view.addSubview(lab)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
          let vc = TestVC()
//        let vc = ViewController()
//        let vc = SubjectsVC()
//        let vc = KVOVC()
//        let vc = TransformingVC()
//        let vc = DriverVC()
//        let vc = ShareReplayVC()
//        let vc = CollectionViewVC()
//        let vc = TableViewVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
