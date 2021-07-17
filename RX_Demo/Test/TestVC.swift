//
//  TestVC.swift
//  RX_Demo
//
//  Created by wcb on 2021/7/17.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestVC: UIViewController {
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var ob1Btn: UIButton!
    @IBOutlet weak var ob2Btn: UIButton!
    @IBOutlet weak var ob3Btn: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //这里必须使用flatMapLatest，否则 self.inputText变动的的时候会打印很多次b、c
       ob1Btn.rx.controlEvent(.touchUpInside).flatMapLatest({[unowned self] _-> Observable<String> in
            print(" B======= ")
           return self.request()
        }).subscribe(onNext: {text in
            print(" C======== \(text)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.bag)
    }
    
    
    func request() ->Observable<String> {
        
        return Observable.create {[unowned self] (ob) -> Disposable in
            self.inputText.rx.text.orEmpty.subscribe(onNext: { text in
                ob.onNext(text)
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.bag)
            return Disposables.create()
        }
    }
}
