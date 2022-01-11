//
//  Reactor_PulseVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/4.
//  Copyright © 2022 fst. All rights reserved.
//

import ReactorKit
import UIKit

// Reactor
private final class MyReactor: Reactor {
    var initialState = State()

    enum Action {
        case doSomeAction
        case alert(_ message: String)
    }

    enum Mutation {
        case setAlertMessage(_ message: String)
    }

    struct State {
        @Pulse var alertMessage: String?
        @Pulse var messages: [String] = []
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .alert(message):
            return Observable.just(Mutation.setAlertMessage(message))
        default:
            return Observable.empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setAlertMessage(alertMessage):
            newState.alertMessage = alertMessage
            newState.messages.append(alertMessage)
        }
        return newState
    }
}

class Reactor_PulseVC: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        let reactor = MyReactor()
        // pulse:解决自定义数据类型时需要自己实现Equatable协议，才能使用distinctUntilChanged过滤的问题
        /*
         写法一
         reactor.pulse({ state in
         state.$messages
         })
         .subscribe(onNext: { messages in
             print("文字信息 ======= \(messages)")
         })
         .disposed(by: disposeBag)
         */
        reactor.pulse(\.$messages)
        .subscribe(onNext: { messages in
            print("文字信息 ======= \(messages)")
        })
        .disposed(by: disposeBag)
        
        // Cases
        reactor.action.onNext(.alert("Hello")) // showAlert() is called with `Hello`

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            reactor.action.onNext(.alert("Hello")) // showAlert() is called with `Hello`
            reactor.action.onNext(.doSomeAction) // showAlert() is not called
            reactor.action.onNext(.alert("Hello")) // showAlert() is called with `Hello`
            reactor.action.onNext(.alert("tokijh")) // showAlert() is called with `tokijh`
            reactor.action.onNext(.doSomeAction) // showAlert() is not called
        }
    }
}
