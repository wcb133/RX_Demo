//
//  mainReactor.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/13.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import ReactorKit

class MainReactor: Reactor {
    let initialState = State()
    
    enum Action {
        case  updateText(text:String)
    }
    
    enum Mutation {
        case  didLoadData(contents:[String])
    }
    
    struct State {
        var allDatas:[String] = []
        var moreDatas:[String] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateText(let text):
            return Observable.just(text).map { _ in
                let contents = (0..<10).map { i in
                    return "这是第一个分组\(i)"
                }
                return Mutation.didLoadData(contents: contents)
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .didLoadData(contents):
           newState.moreDatas = contents
           newState.allDatas = newState.allDatas + contents
            
          return newState
        }
    }
    
}
