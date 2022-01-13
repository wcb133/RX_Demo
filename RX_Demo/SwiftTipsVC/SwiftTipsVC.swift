//
//  SwiftTipsVC.swift
//  RX_Demo
//
//  Created by wcb on 2022/1/13.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit


class SwiftTipsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nums = [2,5,6,9,10,30]
        
        let isHave = nums.contains(where: {$0 == 5})
        
        // 大于9的元素
        let bigNums = nums.prefix(while: { $0 >= 9})
        // 删除大于9的元素
        let smallNums = nums.drop(while: { $0 >= 9})
        
        print(" ====== \(isHave) == \(bigNums) == \(smallNums)")
        
        //字符串转化数组
        let line = "I don't want realism. I want magic!"

        let wordArr = line.split(whereSeparator: { $0 == " " })
        // ["I", "don\'t", "want", "realism.", "I", "want", "magic!"]
        
    }
}
