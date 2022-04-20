//
//  SkeletonViewView.swift
//  RX_Demo
//
//  Created by wcb on 2022/4/20.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

class SkeletonViewView: UIView {

   class func loadNib() ->SkeletonViewView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! SkeletonViewView
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        showAnimatedGradientSkeleton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.showAnimatedGradientSkeleton()
    }

}
