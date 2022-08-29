//
//  TbaleViewTestVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/8/2.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import SnapKit

class TbaleViewTestVC: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.rowHeight = 127
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.backgroundColor = .red
//        tableView.register(UINib(nibName: "\(UITableViewCell.self)", bundle: nil), forCellReuseIdentifier: "ID")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        tableView.separatorColor = .red
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { m in
            m.edges.equalTo(0)
        }
        return tableView
    }()

    var sections = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .red
        tableView.reloadData()

        let x = 1.5
        let y = 1.4
        let z = 1.8
        print(" ===== \(x.rounded())= \(y.rounded())= \(z.rounded())")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.sections = 9
//            self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
}

extension TbaleViewTestVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("分组 ====== \(section)")
        if section == 1 {
            return sections
        }
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 84
    }
}
