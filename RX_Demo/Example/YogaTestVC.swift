//
//  YogaTestVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/4.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import YogaKit

class YogaTestVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let bigBtnH: CGFloat = 120
        
        let containerView = UIView()
        containerView.backgroundColor = .green
        self.view.addSubview(containerView)
        containerView.configureLayout { layout in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.flexWrap = .wrap
            layout.padding = 15
//            layout.width = .init(SCREEN_W)
        }
        
        let bigBtn = UIButton()
        bigBtn.setTitle("大按钮", for: .normal)
        bigBtn.backgroundColor = .blue
        containerView.addSubview(bigBtn)
        
        bigBtn.configureLayout { layout in
            layout.isEnabled = true
//            layout.flexDirection = .row
            layout.height = .init(bigBtnH)
            layout.width = .init(bigBtnH)
        }
        
        let rightView = UIView()
        rightView.backgroundColor = .yellow
        containerView.addSubview(rightView)
        rightView.configureLayout { layout in
            layout.isEnabled = true
            layout.height = .init(bigBtnH)
            layout.flexWrap = .wrap
            layout.flexGrow = 1
//            layout.width = .init(SCREEN_W - bigBtnH)
        }
        
        let items = ["出境旅游", "游轮", "国内游", "攻略"]
        items.forEach { item in
            let btn = UIButton()
            btn.setTitle(item, for: .normal)
            btn.backgroundColor = .blue
            rightView.addSubview(btn)
            btn.configureLayout { layout in
                layout.isEnabled = true
//                layout.height = YGValue(bigBtnH * 0.5)
//                layout.flexGrow = 2
                // 外部间距
                layout.margin = 5
                // 对齐方式
//                layout.alignItems = YGAlign.center
//                layout.width = YGValue(80)
            }
        }
        
        // 最底部的容器view也需要设置
        self.view.configureLayout { layout in
            layout.isEnabled = true
            // self.view直接子视图距离上面的距离
            layout.paddingTop = 100
        }
        
        // 父视图执行布局计算并使用结果更新层次结构中视图的帧
        // applyLayout 中如果参数preservingOrigin被设置为false，则父View会从{0, 0}开始布局
        self.view.yoga.applyLayout(preservingOrigin: true)
    }
}
