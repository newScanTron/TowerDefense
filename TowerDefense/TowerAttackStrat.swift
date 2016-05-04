//
//  TowerAttackStrat.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerAttackStrat
{
    var range : CGFloat = 0
    var damage : CGFloat = 0
    var fireDelay : CGFloat = 0.5
    var speed : CGFloat = 100 // speed the bullets travel
    var target : EnemyBase? = nil
    var rangeLevel : Int = 0
    var damageLevel : Int = 0
    var fireDelayLevel : Int = 0
    var speedLevel : Int = 0
    var imageName : String = "defaultTop"
    
    init () {
    }
    
    
    func Attack(tower : TowerBase) {
    }
    
    func Die(tower : TowerBase) {
    }
    func setRangeLevel(level : Int) {}
    func setDamageLevel(level : Int) {}
    func setFireDelayLevel(level : Int) {}
    func setSpeedLevel(level : Int) {}
    func copy() -> TowerAttackStrat {
        let strat = TowerAttackStrat()
        strat.setRangeLevel(rangeLevel)
        strat.setDamageLevel(damageLevel)
        strat.setFireDelayLevel(fireDelayLevel)
        strat.setSpeedLevel(speedLevel)
        return strat
    }
}