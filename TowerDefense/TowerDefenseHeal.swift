//
//  TowerDefenseHeal.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/1/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerDefenseHeal : TowerDefenseStrat {
    
    var inRange : [TowerBase] = [TowerBase]()
    
    override init () {
        super.init()
        self.setRangeLevel(0)
        self.setAmountLevel(0)
    }
    
    override func setRangeLevel(level : Int) {
        rangeLevel = level
        range = 75 + CGFloat(level) * 25
    }
    override func setAmountLevel(level : Int) {
        amountLevel = level
        amount = 2 + CGFloat(level) * 0.5
    }
    
    override func Defend() {
        
        // Find enemies in radius, heal them
        
        inRange = GameScene.getTowersInRange(parent!.sprite.position, range: range)
        
        for t in inRange {
            t.health += amount
            
        }
        
    }
    
}
