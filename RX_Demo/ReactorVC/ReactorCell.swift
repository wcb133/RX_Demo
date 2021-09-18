//
//  ReactorCell.swift
//  RX_Demo
//
//  Created by wcb on 2021/9/13.
//  Copyright © 2021 fst. All rights reserved.
//

import UIKit

class ReactorCell: ASCellNode {
    let textNode = ASTextNode()
    init(title:String) {
        super.init()
        self.addSubnode(textNode)
        textNode.attributedText = NSAttributedString(string: title, attributes: [.foregroundColor:UIColor.red])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        textNode.style.height = ASDimensionMake(50)
        return ASInsetLayoutSpec(insets: .zero, child: textNode)
    }
}
