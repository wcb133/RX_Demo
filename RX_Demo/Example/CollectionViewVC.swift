//
//  CollectionViewVC.swift
//  RX_Demo
//
//  Created by fst on 2019/12/23.
//  Copyright © 2019 fst. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

let SCREEN_W = UIScreen.main.bounds.size.width
let SCREEN_H = UIScreen.main.bounds.size.height
class CollectionViewVC: UIViewController {
    let cellID = "cellID"
    let headerID = "headerID"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREEN_W - 30) / 3, height: (SCREEN_H - 30) / 3)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        return collectionView
    }()

    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("刷新", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.frame.size.width = 60
        btn.frame.size.height = 40
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        return btn
    }()

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .red
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        let datasource = RxCollectionViewSectionedReloadDataSource<CBSetionModel>(configureCell: { ds, collectionView, indexPath, model -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath)
            cell.contentView.backgroundColor = .yellow
            cell.setNeedsDisplay()
            print("内容 ======= \(model.msg)")
            return cell
        }, configureSupplementaryView: { ds, collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerID, for: indexPath)
            print("标题 ======= \(ds[indexPath.section].header)")
            return headerView
        })
        // 刷新触发事件
        btn.rx.tap.subscribe(onNext: { btn in

        }).disposed(by: disposeBag)

        // 获取数据,flatMapLatest 的作用是：当在短时间内（上一个请求还没回来）连续点击多次“刷新”按钮，虽然仍会发起多次请求，但 collectionView 只会接收并显示最后一次请求。避免集合视图出现连续刷新的现象。停止刷新数据，采用takeUntil
//        let ob = btn.rx.tap.asObservable()
//            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)//1s内多次变化，取最后一次
//            .startWith(())//加这个为了让一开始就能自动请求一次数据
//            .flatMapLatest({ () -> Observable<[SetionModel]> in
//                return self.getData()
//            })
//            .asDriver(onErrorJustReturn: [])
        // 简洁写法
        let ob = btn.rx.tap.asObservable()
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // 1s内多次变化，取最后一次
            .startWith(()) // 加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getData)
            .asDriver(onErrorJustReturn: [])

        ob.drive(collectionView.rx.items(dataSource: datasource)).disposed(by: disposeBag)

        // 设置代理
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        // 点击事件
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("点击了========= \(indexPath.row)")
        }).disposed(by: disposeBag)
        collectionView.rx.modelSelected(ItemModel.self).subscribe(onNext: { itemModel in
            print("点击了========= \(itemModel.msg)")
        }).disposed(by: disposeBag)
    }

    func getData() -> Observable<[CBSetionModel]> {
        var itemModels: [ItemModel] = []
        for _ in 0...3 {
            let itemModel = ItemModel()
            itemModels.append(itemModel)
        }
        let setionModels = [CBSetionModel(header: "分组1", items: itemModels)]
        // 延时，模拟网络请求
        return Observable.just(setionModels).delay(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
    }
}

extension CollectionViewVC: UICollectionViewDelegateFlowLayout {
    // 设置单元格尺寸
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 4 // 每行显示4个单元格
        return CGSize(width: cellWidth, height: cellWidth * 1.5) // 单元格宽度为高度1.5倍
    }
}

struct CBSetionModel {
    var header: String
    var items: [ItemModel]
}

extension CBSetionModel: SectionModelType {
    typealias Item = ItemModel

    init(original: CBSetionModel, items: [Item]) {
        self.items = items
        self = original
    }
}

struct ItemModel {
    var msg = "测试数据"
}
