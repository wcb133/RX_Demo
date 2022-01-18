//
//  Offer.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/18.
//  Copyright © 2022 fst. All rights reserved.
//

public func offer(banana: Banana) -> String {
    if banana.isEdible {
        return "Hey, want a banana ?"

    } else {
        return "Hey, want me to peel a banana for u ?"
    }
}
