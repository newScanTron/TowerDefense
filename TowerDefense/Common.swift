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
    static let EnemyBullet       : UInt32 = 0b00100
    static let TowerBullet       : UInt32 = 0b01000
    static let TowerShield       : UInt32 = 0b10000
}

struct CollisionMask { // Which categories should this object "collide" with, i.e. interact with physically. Match with categories above.
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0b0000 // Towers only collide with other Towers and Enemies
    static let Enemy        : UInt32 = 0b0000 // Enemies only collide with other Enemies and Towers
    static let EnemyBullet       : UInt32 = 0b10000 // EnemyBullet only collides with TowerShield
    static let TowerBullet       : UInt32 = 0b00000 // TowerBullet does not collide with anything
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
extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "gridBG")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
    
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}