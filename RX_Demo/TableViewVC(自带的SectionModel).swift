//
//  TableViewVC.swift
//  RX_Demo
//
//  Created by fst on 2019/12/23.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//单元格类
class MyTableCell: UITableViewCell {
     
    var button:UIButton!
    var disposeBag = DisposeBag()
    //单元格重用时调用
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
     
    //初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        //添加按钮
        button = UIButton(frame:CGRect(x:0, y:0, width:40, height:25))
        button.setTitle("点击", for:.normal) //普通状态下的文字
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(button)
    }
     
    //布局
    override func layoutSubviews() {
        super.layoutSubviews()
        button.center = CGPoint(x: bounds.size.width - 35, y: bounds.midY)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

 
class TableViewVC: UIViewController {
    
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
        self.tableView.register(MyTableCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
         
        //创建表头的搜索栏
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                            width: self.view.bounds.size.width, height: 56))
        self.tableView.tableHeaderView =  self.searchBar
         
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult) //获取数据
            .flatMap(filterResult) //筛选数据
            .share(replay: 1)
         
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, Int>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell") as! MyTableCell
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                //下面的闭包需要弱引用self,注意这里的disposed是由cell里面的disposeBag控制
                cell.button.rx.tap.subscribe(onNext: { () in
                    print(" ======== 点击了按钮\(indexPath.row)")
                }).disposed(by: cell.disposeBag)
                return cell
            })
         
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
     
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    }
     
    //过滤数据
    func filterResult(data:[SectionModel<String, Int>])
        -> Observable<[SectionModel<String, Int>]> {
        return self.searchBar.rx.text.orEmpty
            //.debounce(0.5, scheduler: MainScheduler.instance) //只有间隔超过0.5秒才发送
            .flatMapLatest{
                query -> Observable<[SectionModel<String, Int>]> in
                print("正在筛选数据（条件为：\(query)）")
                //输入条件为空，则直接返回原始数据
                if query.isEmpty{
                    return Observable.just(data)
                }
                //输入条件为不空，则只返回包含有该文字的数据
                else{
                    var newData:[SectionModel<String, Int>] = []
                    for sectionModel in data {
                        let items = sectionModel.items.filter{ "\($0)".contains(query) }
                        newData.append(SectionModel(model: sectionModel.model, items: items))
                    }
                    return Observable.just(newData)
                }
        }
    }
}
