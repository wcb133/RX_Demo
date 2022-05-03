//
//  ASButtonNodeProtocol.swift
//  WebMarket
//
//  Created by Weicb on 2022/5/3.
//  Copyright © 2022 buydeem. All rights reserved.
//

import AsyncDisplayKit
import UIKit

protocol ASButtonNodeProtocol: ASDisplayNodeProtocol {
    @discardableResult @inlinable
    func image(_ image: UIImage?, for state: UIControl.State) -> Self
    @discardableResult @inlinable
    func backgroundImage(_ image: UIImage?, for state: UIControl.State) -> Self
    @discardableResult @inlinable
    func contentSpacing(_ value: CGFloat) -> Self
    @discardableResult @inlinable
    func title(_ title: String, font: UIFont?, color: UIColor, for state: UIControl.State) -> Self
    @discardableResult @inlinable
    func attributedTitle(_ attributedTitle: NSAttributedString, for state: UIControl.State) -> Self

    @discardableResult @inlinable
    func contentEdgeInsets(_ insets: UIEdgeInsets) -> Self

    @discardableResult @inlinable
    func contentVerticalAlignment(_ alignment: ASVerticalAlignment) -> Self

    @discardableResult @inlinable
    func contentHorizontalAlignment(_ alignment: ASHorizontalAlignment) -> Self
}

extension ASButtonNode: ASButtonNodeProtocol {
    @discardableResult @inlinable
    func image(_ image: UIImage?, for state: UIControl.State) -> Self {
        setImage(image, for: state)
        return self
    }

    @discardableResult @inlinable
    func backgroundImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }

    @discardableResult @inlinable
    func contentSpacing(_ value: CGFloat) -> Self {
        contentSpacing = value
        return self
    }

    @discardableResult @inlinable
    func title(_ title: String, font: UIFont?, color: UIColor, for state: UIControl.State) -> Self {
        setTitle(title, with: font, with: color, for: state)
        return self
    }

    @discardableResult @inlinable
    func attributedTitle(_ attributedTitle: NSAttributedString, for state: UIControl.State) -> Self {
        setAttributedTitle(attributedTitle, for: state)
        return self
    }

    @discardableResult @inlinable
    func contentEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        contentEdgeInsets = insets
        return self
    }

    @discardableResult @inlinable
    func contentVerticalAlignment(_ alignment: ASVerticalAlignment) -> Self {
        contentVerticalAlignment = alignment
        return self
    }

    @discardableResult @inlinable
    func contentHorizontalAlignment(_ alignment: ASHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }
}
