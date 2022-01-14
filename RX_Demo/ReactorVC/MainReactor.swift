//
//  mainReactor.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/13.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import ReactorKit
import RxRelay

class MainReactor: Reactor {
    // global state
    var currentUser: BehaviorRelay<String> = BehaviorRelay(value: "全局数据")

    let initialState = State()

    enum Action {
        case updateText(text: String)
        case insertData(text: String)
    }

    enum Mutation {
        case didLoadData(contents: [String])
        case insertData(text: String)
        case currentUserUpdate(name: String)
    }

    struct State {
        var allDatas: [String] = []
        var moreDatas: [String] = []
        var userName = ""
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateText(text):
            return Observable.just(text).map { _ in
                var contents = (0..<10).map { i in
                    "这是第一个分组\(i)"
                }
                // 只加载20条
                if self.currentState.allDatas.count >= 20 {
                    contents = []
                }
                return Mutation.didLoadData(contents: contents)
            }
        case let .insertData(text):
            return Observable.just(text).map {
                Mutation.insertData(text: "这是插入的新的cell\($0)")
            }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .didLoadData(contents):
            newState.moreDatas = contents
            newState.allDatas = newState.allDatas + contents
        case let .insertData(text):
//            var allDatas = newState.allDatas
//            allDatas.append(text)
//            newState.allDatas = allDatas
            newState.allDatas.append(text)
        case let .currentUserUpdate(name):
            newState.userName = name
        }

        return newState
    }

    // 调试用，或者是实现Global States (全局状态)
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        print(" ======== 执行了")

        return Observable.merge([mutation, currentUser.map { name in
            Mutation.currentUserUpdate(name: name)
        }])
    }
}
