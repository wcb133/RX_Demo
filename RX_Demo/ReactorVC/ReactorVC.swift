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
import RxCocoa

// View 通信
/*
 多个 view 之间通信时，通常会采用回调闭包或者代理模式。ReactorKit 建议采用 reactive extensions 来解决。最常见的 ControlEvent 示例是 UIButton.rx.tap。关键思路就是将自定义的视图转化为像 UIButton 或者 UILabel 一样。
 */
extension Reactive where Base: MessageInputView {
    var sendMessage: ControlEvent<String> {
        let ob = base.sendBtn.rx.tap.withLatestFrom(base.searchTF.rx.text.orEmpty)
        return ControlEvent(events: ob)
    }
}

class MessageInputView: UIView {
    let searchTF = UITextField().then { n in
        n.placeholder = "输入文字"
    }

    let sendBtn = UIButton().then { btn in
        btn.setTitle("发送", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .red
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sendBtn)
        sendBtn.snp.makeConstraints { m in
            m.right.equalTo(-12)
            m.top.equalTo(12)
            m.bottom.equalTo(-12)
            m.width.equalTo(80)
        }

        addSubview(searchTF)
        searchTF.snp.makeConstraints { m in
            m.left.equalTo(12)
            m.top.equalTo(12)
            m.bottom.equalTo(-12)
            m.right.equalTo(sendBtn.snp.left).offset(-12)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ReactorVC: UIViewController, View {
    typealias Reactor = MainReactor
    var disposeBag = DisposeBag()

    private lazy var tableNode = ASTableNode(style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.view.tableFooterView = UIView()
        self.view.addSubnode($0)
        $0.view.contentInsetAdjustmentBehavior = .never
        if #available(iOS 13.0, *) {
            $0.view.automaticallyAdjustsScrollIndicatorInsets = false
        }
        $0.view.snp.makeConstraints { m in
            m.left.right.top.equalTo(0)
            m.bottom.equalTo(self.msgInputView.snp.top)
        }
    }

    lazy var msgInputView: MessageInputView = .init().then { n in
        view.addSubview(n)
        n.backgroundColor = .yellow
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置reactor
        reactor = MainReactor()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)

        msgInputView.snp.makeConstraints { m in
            m.left.right.bottom.equalTo(0)
            m.height.equalTo(60)
        }
        tableNode.view.backgroundColor = .green

        // 测试全局状态
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.reactor?.currentUser.accept("哈哈哈，名字改变了")
        }
    }

    func bind(reactor: MainReactor) {
//        self.searchTF.rx.text.orEmpty.distinctUntilChanged().map { text in
//            return Reactor.Action.updateText(text: text)
//        }.bind(to: reactor.action).disposed(by: disposeBag)

//        self.sendBtn.rx.tap.withLatestFrom(self.searchTF.rx.text.orEmpty).map { message in
//            return MainReactor.Action.insertData(text: message)
//        }.bind(to: reactor.action).disposed(by: disposeBag)

        msgInputView.rx.sendMessage.map { message in
            MainReactor.Action.insertData(text: message)
        }.bind(to: reactor.action).disposed(by: disposeBag)

        // 加过滤
//        reactor.state.subscribe(onNext:{ state in
        ////            self.tableNode.reloadData()
//            let count = state.allDatas.count - state.moreDatas.count
//            if count <= 0 { return }
//            let indexPaths = (count..<state.allDatas.count).map { row in
//                return IndexPath(row: row, section: 0)
//            }
//            self.tableNode.insertRows(at: indexPaths, with: .none)
//        }).disposed(by: disposeBag)

        // 这里主要是为了使用而已，实际上的插入应该和加载更多一个触发事件就可以了
        reactor.state
            .map { $0.allDatas }
            .distinctUntilChanged() // 要加这个过滤，否则其他的state变化也会影响这边
            .subscribe(onNext: { allData in
                let indexPath = IndexPath(row: allData.count - 1, section: 0)
                self.tableNode.insertRows(at: [indexPath], with: .none)

            }).disposed(by: disposeBag)

//        reactor.state.mapThenUntilChanged({$0.moreDatas})

        reactor.state.mapThenUntilChanged { $0.userName }.subscribe(onNext: { useName in
            print("监听回调 ========== \(useName)")
        }).disposed(by: disposeBag)
    }
}

extension ReactorVC: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return reactor?.currentState.allDatas.count ?? 0
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let data = reactor!.currentState.allDatas[indexPath.row]
        print(" 标题 ======= \(data)")
        return {
            return ReactorCell(title: data)
        }
    }
}
