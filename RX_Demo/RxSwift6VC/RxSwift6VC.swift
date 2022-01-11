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

class RxTestView:UIView {
    var title = ""
}

class RxSwift6VC: UIViewController {
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var ob1Btn: UIButton!
    @IBOutlet weak var ob2Btn: UIButton!
    @IBOutlet weak var ob3Btn: UIButton!
    
    var buidBag = DisposeBag()
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //这里必须使用flatMapLatest，否则 self.inputText变动的的时候会打印很多次b、c
       ob1Btn.rx.controlEvent(.touchUpInside).flatMapLatest({[unowned self] _-> Observable<String> in
            print(" B======= ")
           return self.request()
        }).subscribe(onNext: {text in
            print(" C======== \(text)")
        }).disposed(by: self.bag)
        
//        ob2Btn.rx.tap.subscribeNext(weak: self) { ob in
//           let tx = ob.inputText.text
//            print(" ======= \(ob)")
//        }
        
        let testView = RxTestView()
        // DisposeBag(builder: <#T##() -> [Disposable]#>)
        buidBag = DisposeBag {
            // withUnretained(self)
            ob2Btn.rx.tap.withUnretained(self).subscribe(onNext: { weakSelf,_ in
                print(" ======= \(weakSelf)")
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
            ob3Btn.rx.tap.withUnretained(self).subscribe(onNext: { weakSelf,_ in
                print(" ======= \(weakSelf)")
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
            // distinctUntilChange(at:)、dynamicMemberLookup和keyPath
            Observable.just(CBPerson(name: "标题", age: 18)).distinctUntilChanged(at: \.age).map(\.name).bind(to: testView.rx.title)
        }
        
        print(" ========= \(testView.title)")
    }
    
    
    func request() ->Observable<String> {
        return Observable.create {[unowned self] (ob) -> Disposable in
            self.inputText.rx.text.orEmpty.subscribe(onNext: { text in
                ob.onNext(text)
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
    deinit {
        print(" ======== 释放")
    }
}
