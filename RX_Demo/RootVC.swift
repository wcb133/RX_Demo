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


struct TBSectionModel {
    var title:String
    var items: [String]
}

extension TBSectionModel:SectionModelType {
    
    typealias Item = String
    
    init(original: TBSectionModel, items: [String]) {
        self.items = items
        self.title = original.title
    }
    
}

let demoCellID = "demoCellID"
class RootVC: UIViewController {
    
    lazy var tab = UITableView(frame: .zero, style: .plain).then { tab in
        tab.register(UITableViewCell.self, forCellReuseIdentifier: demoCellID)
        tab.rowHeight = 50
        self.view.addSubview(tab)
        tab.snp.makeConstraints { m in
            m.edges.equalTo(0)
        }
    }
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let rxDs = RxTableViewSectionedReloadDataSource<TBSectionModel> { ds, tab, indexPath, content in
            let cell = tab.dequeueReusableCell(withIdentifier: demoCellID, for: indexPath)
            cell.textLabel?.text = content
            cell.accessoryType = .disclosureIndicator
            return cell
        }titleForHeaderInSection: { ds, section in
            return ds[section].title
        }
        
        //设置代理
//         tab.rx.setDelegate(self)
//             .disposed(by: bag)
        let vcs:[UIViewController.Type] = [ReactorVC.self,RxSwift6VC.self,ViewController.self,
                                          SubjectsVC.self,KVOVC.self,TransformingVC.self,
                                          DriverVC.self,ShareReplayVC.self,CollectionViewVC.self,
                                          TableViewVC.self,DelegateProxyVC.self,TestVC.self]
        
        
        let items:[String] = vcs.map {"\($0)" }
        let sectionModel = TBSectionModel(title: "Demo", items: items)
        Observable.just([sectionModel]).bind(to: self.tab.rx.items(dataSource: rxDs)).disposed(by: bag)
        
        self.tab.rx.itemSelected.subscribe(onNext:{ indexPath in
            self.tab.deselectRow(at: indexPath, animated: true)
            let vc = vcs[indexPath.row]
            self.navigationController?.pushViewController(vc.init(), animated: true)
        }).disposed(by: bag)
        
        
    }
}
