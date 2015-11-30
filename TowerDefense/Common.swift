//
//  Common.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/28/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

struct CategoryMask { // Assigns categories for use with CollisionMask and ContactMask. Should all only have one 1 digit.
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0b0001
    static let Enemy        : UInt32 = 0b0010
    static let EnemyBullet       : UInt32 = 0b0100
    static let TowerBullet       : UInt32 = 0b1000
}

struct CollisionMask { // Which categories should this object "collide" with, i.e. interact with physically. Match with categories above.
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max

    static let Tower        : UInt32 = 0b0011 // Towers only collide with other Towers and Enemies
    static let Enemy        : UInt32 = 0b0100 // Enemies only collide with other Enemies and Towers
    static let EnemyBullet       : UInt32 = 0b0000 // Bullets don't collide with anything (only trigger contacts against enemies/towers)
    static let TowerBullet       : UInt32 = 0b0000
}

struct ContactMask { // Which categories should this object trigger notifications about, i.e. in didBeginContact(). Match with categories above.
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0
    static let Enemy        : UInt32 = 0
    static let EnemyBullet  : UInt32 = 0b0001 // EnemyBullet should only trigger contacts with Towers, so they can deal damage then be destroyed
    static let TowerBullet  : UInt32 = 0b0010 // TowerBullet should only trigger contacts with Enemies, so they can deal damage then be destroyed
}

struct ZPosition {
    static let background  : CGFloat = -10
    static let wall         : CGFloat = 0
    static let tower        : CGFloat = 5
    static let enemy        : CGFloat = 6
    static let bullet       : CGFloat = 7
}
enum PhysicsCategory : UInt32 {
    case None   = 0
    case All    = 0xFFFFFFFF
    case Tower  = 0b0001
    case Enemy  = 0b0010
    case EnemyBullet = 0b0100
    case TowerBullet = 0b1000
}