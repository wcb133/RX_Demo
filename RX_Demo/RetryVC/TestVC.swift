//
//  TestVC.swift
//  RX_Demo
//
//  Created by Weicb on 2021/9/5.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import RxSwift

enum RetryError: Error {
    case errorNumber
}

class TestVC: UIViewController {

    @IBOutlet weak var btn: UIButton!
    let bag = DisposeBag()
    
    var count:Int = 0
    
    private static let bag = DisposeBag()
    private static var retryCount = 1           // 当前重试次数
    private static let maxRetryCount = 5        // 最多重试次数
    private static let retryDelay: Int = 3   // 多少秒重试一次
    
    static func test() {
        let get5 = Single<Bool>.create(subscribe: { single in
            if retryCount == maxRetryCount {
                retryCount = 1
                single(.success(true))
            } else {
                print("当前重试次数: ", retryCount)
                retryCount += 1
                single(.failure(RetryError.errorNumber))
            }
            return Disposables.create()
        })
        
        get5.asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .retry { (error) -> Observable<Int> in
                return error.flatMap({ (er) -> Observable<Int> in
                    guard retryCount < maxRetryCount+1 else {
                        return Observable.error(er)
                    }
                    return Observable.timer(.seconds(retryDelay), scheduler: MainScheduler.asyncInstance)
                })
            }
            .subscribe(onNext: { bool in
                print("bool =", bool)
            }, onError: { error in
                switch (error as! RetryError) {
                case .errorNumber:
                    print("number error")
                }
            }, onCompleted: {
                print("completed")
            })
            .disposed(by: bag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.asyncInstance).groupBy(keySelector: {
            seconds in
            return seconds < 100
        }).subscribe(onNext: {
            [unowned self] event in
            print(" ============== \(event)")
            if event.key {
                
            } else {
                
            }
        }).disposed(by: bag)
    }
    
    
    func testRetry()  {
        let retry = btn.rx.tap.flatMap { _->Observable<Int> in
            return .create { ob in
                if self.count < 3 {
                let err = NSError(domain: "测试", code: 20, userInfo: ["key":"userInfo"])
                    ob.onError(err)
                }else{
                    ob.onNext(self.count)
                }
                return Disposables.create()
            }
        }
        
        //这个retry没成功,原因未知(上面的btn.rx.tap改成Observable.just(1)后，会成功)
        retry.retry(when: { errOb in
            return errOb.flatMap { err -> Observable<Int> in
                print("错误 ======== \(err)")
                return Observable.timer(RxTimeInterval.seconds(3), scheduler: MainScheduler.asyncInstance)
            }
        }).subscribe(onNext:{ count in
            print(" ======== \(count)")
        }).disposed(by: bag)
        
        
//        retry.subscribe(onNext:{ count in
//            print(" ======== \(count)")
//
//        }).disposed(by: bag)
        

        //重试
//        btn.rx.tap.subscribe(onNext:{ _ in
//            Self.test()
//        }).disposed(by: bag)

        
        //延时
//        btn.rx.tap.delay(5, scheduler: MainScheduler.asyncInstance
//        ).subscribe(onNext:{ _ in
//            print(" ======= ")
//        }).disposed(by: bag)
        //失败重试
//        btn.rx.tap.flatMap({ [unowned self] _  in
//            self.request().asObservable().flatMap({ code -> Observable<Int> in
//                if code == 1 {
//                    let error = NSError(domain: "域名", code: 200, userInfo: [:])
//                    return .error(error)
//                }else{
//                    return .just(6)
//                }
//            }).retryWhen({ err in
//                return err.enumerated().flatMap { idx,err -> Observable<Int> in
//                    print("错误 ===========\(idx) ===== \(err)")
//                    return Observable<Int>.timer(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
//                }
//            })
//        }).observeOn(MainScheduler.asyncInstance).subscribe(onNext:{ ti in
//            print(" ======= 重试测试\(ti)")
//        }).disposed(by: bag)
    }
    
    
    func request() -> Single<Int> {
        return .create { ob in
            if self.count < 3 {
                self.count += 1
                ob(.success(1))
            }else{
                ob(.success(2))
            }
            return Disposables.create()
        }
    }
    
    
}
