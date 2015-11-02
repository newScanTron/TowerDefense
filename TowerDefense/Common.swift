//
//  Common.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/28/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0b1
    static let Enemy       : UInt32 = 0b10
    static let Bullet   : UInt32 = 0b11
}

