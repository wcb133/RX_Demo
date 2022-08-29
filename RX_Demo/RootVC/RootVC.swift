//
//  RootVC.swift
//  RX_Demo
//
//  Created by wcb on 2021/7/17.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import ReactorKit

struct TBSectionModel {
    var title: String
    var items: [String]
}

extension TBSectionModel: SectionModelType {
    typealias Item = String

    init(original: TBSectionModel, items: [String]) {
        self.items = items
        title = original.title
    }
}

let demoCellID = "demoCellID"
class RootVC: UIViewController, View {
    lazy var tab = UITableView(frame: .zero, style: .plain).then { tab in
        tab.register(UITableViewCell.self, forCellReuseIdentifier: demoCellID)
        tab.rowHeight = 50
        self.view.addSubview(tab)
        tab.snp.makeConstraints { m in
            m.edges.equalTo(0)
        }
    }

    var disposeBag: DisposeBag = .init()
    typealias Reactor = RootReactor

    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = RootReactor()
        print(" ======= viewDidLoad")
        // 设置代理
//         tab.rx.setDelegate(self)
//             .disposed(by: bag)
    }

    func bind(reactor: RootReactor) {
        Observable.just(1).map { k in
            RootReactor.Action.addExample
        }.bind(to: reactor.action).disposed(by: disposeBag)

        // 表格
        let rxDs = RxTableViewSectionedReloadDataSource<TBSectionModel> { ds, tab, indexPath, content in
            let cell = tab.dequeueReusableCell(withIdentifier: demoCellID, for: indexPath)
            cell.textLabel?.text = content
            cell.accessoryType = .disclosureIndicator
            return cell
        } titleForHeaderInSection: { ds, section in
            ds[section].title
        }

        reactor.state.map { state in
            state.tableData
        }.asDriver(onErrorJustReturn: []).drive(tab.rx.items(dataSource: rxDs)).disposed(by: disposeBag)

        tab.rx.itemSelected.subscribe(onNext: { indexPath in
            self.tab.deselectRow(at: indexPath, animated: true)
            let vc = self.reactor!.currentState.vcs[indexPath.row]
            self.navigationController?.pushViewController(vc.init(), animated: true)
        }).disposed(by: disposeBag)
    }
}
