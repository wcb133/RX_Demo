//
//  niceVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/5/2.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit
import AsyncDisplayKit

protocol ASDisplayNodeProtocol: NSObjectProtocol {
    @discardableResult @inlinable
    func backgroundColor(_ color: UIColor) -> Self
    @discardableResult @inlinable
    func cornerRadius(_ radius: CGFloat) -> Self
    @discardableResult @inlinable
    func clipsToBounds(_ value: Bool) -> Self
    @discardableResult @inlinable
    func hitTestSlop(_ insets: UIEdgeInsets) -> Self
    @discardableResult @inlinable
    func borderWidth(_ value: CGFloat) -> Self
    @discardableResult @inlinable
    func borderColor(_ color: UIColor) -> Self
    @discardableResult @inlinable
    func isHidden(_ value: Bool) -> Self
}

extension ASDisplayNode: ASDisplayNodeProtocol {
    @discardableResult @inlinable
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult @inlinable
    func cornerRadius(_ radius: CGFloat) -> Self {
        cornerRadius = radius
        return self
    }

    @discardableResult @inlinable
    func clipsToBounds(_ value: Bool) -> Self {
        clipsToBounds = value
        return self
    }

    @discardableResult @inlinable
    func hitTestSlop(_ insets: UIEdgeInsets) -> Self {
        hitTestSlop = insets
        return self
    }

    @discardableResult @inlinable
    func borderWidth(_ value: CGFloat) -> Self {
        borderWidth = value
        return self
    }

    @discardableResult @inlinable
    func borderColor(_ color: UIColor) -> Self {
        borderColor = color.cgColor
        return self
    }

    @discardableResult @inlinable
    func isHidden(_ value: Bool) -> Self {
        isHidden = value
        return self
    }
}
