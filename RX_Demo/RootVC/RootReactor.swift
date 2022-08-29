//
//  RootReactor.swift
//  RX_Demo
//
//  Created by Weicb on 2021/9/20.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import ReactorKit

class RootReactor: Reactor {
    var initialState: State = .init()

    enum Action {
        case addExample
        case test
    }

    enum Mutation {
        case addExample
        case test
    }

    struct State {
        let vcs: [UIViewController.Type] = [ReactorVC.self, RxSwift6VC.self, ViewController.self,
                                            SubjectsVC.self, KVOVC.self, TransformingVC.self,
                                            DriverVC.self, ShareReplayVC.self, CollectionViewVC.self,
                                            TableViewVC.self, DelegateProxyVC.self, RetryVC.self, TableViewOneSectionVC.self, YogaTestVC.self, DynamicMemberLookupVC.self, KeyPathVC.self, ScheduleVC.self, SwiftTipsVC.self, SwiftCompileVC.self,
                                            ResolverTestVC.self, DeviceKitVC.self, SwiftDateVC.self, SkeletonViewVC.self, CTMediatorHomeVC.self, CodableDemoVC.self, blockVC.self, VarIsOrNotThreadSafeVC.self, RefCountTestVC.self, TbaleViewTestVC.self]

        var tableData: [TBSectionModel] = []
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .addExample:
            return Observable.just(1).map { k in
                Mutation.addExample
            }
        case .test:
            return Observable.empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .addExample:
            let items: [String] = state.vcs.map { "\($0)".replacingOccurrences(of: "VC", with: "") }
            let sectionModel = TBSectionModel(title: "Demo", items: items)
            state.tableData = [sectionModel]
        case .test:
            break
        }

        return state
    }
}
