//
//  TowerMainStat.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/24/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
//Main Tower Attack Strat
class TowerMainAttackStrat : TowerAttackStrat
{
    var lastFire : CGFloat = 0
    
    override init() {
        super.init()
        imageName = "tempMainTower"
        self.setRangeLevel(0)
        self.setDamageLevel(0)
        self.setFireDelayLevel(0)
    }
}
//Main Tower Defense Start
class TowerMainDefenseStrat : TowerDefenseStrat
{
    override init() {
        super.init()
        imageName = "tempMainTower"
    }
}