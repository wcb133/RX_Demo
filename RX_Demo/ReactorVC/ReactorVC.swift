//
//  ReactorVC.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/13.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import Then
import ReactorKit

class ReactorVC: UIViewController,View {
    typealias Reactor = MainReactor
    var disposeBag = DisposeBag()
    
    
    private lazy var tableNode = ASTableNode(style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.view.tableFooterView = UIView()
//        $0.view.separatorStyle = .none
        self.view.addSubnode($0)
        $0.view.contentInsetAdjustmentBehavior = .never
        if #available(iOS 13.0, *) {
            $0.view.automaticallyAdjustsScrollIndicatorInsets = false
        }
        $0.view.snp.makeConstraints { m in
            m.edges.equalTo(0)
        }
    }
    
    let searchTF = UITextField().then { n in
        n.placeholder = "输入文字"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = MainReactor()//设置reactor
//        debugPrint(" ======= \(viewController)")
        
        self.searchTF.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        self.navigationItem.titleView = self.searchTF
        self.tableNode.view.backgroundColor = .green
    }
    
    func bind(reactor: MainReactor) {
        self.searchTF.rx.text.orEmpty.distinctUntilChanged().map { text in
            return Reactor.Action.updateText(text: text)
        }.bind(to: reactor.action).disposed(by: disposeBag)
        
        reactor.state.subscribe(onNext:{ state in
//            self.tableNode.reloadData()
            let count = state.allDatas.count - state.moreDatas.count
            let indexPaths = (count..<state.allDatas.count).map { row in
                return IndexPath(row: row, section: 0)
            }
            self.tableNode.insertRows(at: indexPaths, with: .none)
        }).disposed(by: disposeBag)
        
    }
    
    
    
}

extension ReactorVC:ASTableDelegate,ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.reactor?.currentState.allDatas.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let data = self.reactor!.currentState.allDatas[indexPath.row]
        print(" 标题 ======= \(data)")
        return {
            return ReactorCell(title: data)
        }
    }
}
