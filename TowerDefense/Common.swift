//
//  Common.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/28/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0b1
    static let Enemy       : UInt32 = 0b10
    static let Bullet   : UInt32 = 0b11
}

struct ZPosition {
    static let background  : CGFloat = -10
    static let wall         : CGFloat = 0
    static let tower        : CGFloat = 5
    static let enemy        : CGFloat = 6
    static let bullet       : CGFloat = 7
}