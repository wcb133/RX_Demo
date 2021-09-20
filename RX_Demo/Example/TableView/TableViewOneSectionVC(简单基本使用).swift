//
//  TableViewOneSectionVC.swift
//  RX_Demo
//
//  Created by Weicb on 2021/9/20.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources




 
class TableViewOneSectionVC: UIViewController {
    
    let refreshButton = UIButton()
    //表格
    var tableView:UITableView!
     
    //搜索栏
    var searchBar:UISearchBar!
     
    let disposeBag = DisposeBag()
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView.register(CBTableCell.self,forCellReuseIdentifier: CBTableCell.reuseID)
        self.view.addSubview(self.tableView!)
        
        //绑定单元格数据，多类型的表格
//        Observable.just(["1","2","3","4"]).bind(to: tableView.rx.items) { (tableView, row, element) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//            cell.textLabel?.text = "======\(row)：\(element)"
//            return cell
//        }
//        .disposed(by: disposeBag)
        
        print(" ====  \(UITableViewCell.reuseID)")
        //单个样式的表格可以这么注册
        Observable.just(["1","2","3","4"]).bind(to: tableView.rx.items(cellIdentifier:CBTableCell.reuseID, cellType: CBTableCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "======\(row)：\(element) ==== \(CBTableCell.reuseID)"
        }
        .disposed(by: disposeBag)
        
        
    }
}


class CBTableCell: UITableViewCell {
    
}


