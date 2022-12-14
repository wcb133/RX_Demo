//
//  SkeletonViewVC.swift
//  RX_Demo
//
//  Created by wcb on 2022/4/20.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import SnapKit
import SkeletonView
import RxUIAlert
import NSObject_Rx

class SkeletonViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let testView = SkeletonViewView.loadNib()
        self.view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        let redView = UIView()
        testView.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(200)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        

        rx.alert(title: "RxAlert",
                 message: "We have made it easy to implement UIAlertController using RxSwift.",
                 actions: [AlertAction(title: "OK", type: 0, style: .default),
                           AlertAction(textField: UITextField(), placeholder: "user name"),
                           AlertAction(textField: UITextField(), placeholder: "password")])
            .subscribe(onNext: { (output) in
                output.textFields?.forEach {
                    print ($0.text as? String?)
                }})
            .disposed(by: rx.disposeBag)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
