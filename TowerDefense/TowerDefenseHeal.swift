//
//  TowerDefenseHeal.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/1/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation

class TowerDefenseHeal : TowerDefenseStrat {
    
    var inRange : [TowerBase] = [TowerBase]()
    
    override init () {}
    
    override func Defend() {
        
        // Find enemies in radius, heal them
        
        inRange = GameScene.getTowersInRange(parent!.sprite.position, range: range)
        
        for t in inRange {
            t.health += amount
            
        }
        
    }
    
}
