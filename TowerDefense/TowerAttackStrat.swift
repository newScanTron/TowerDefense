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
    var speed : CGFloat = 100
    var target : EnemyBase? = nil
    //var parent : TowerBase? = nil
    var rangeLevel : Int = 0
    var damageLevel : Int = 0
    var fireDelayLevel : Int = 0
    var speedLevel : Int = 0
    var imageName : String = "defaultTop"
//    var expLevel : Int = 0
//    var homingLevel : Int = 0
    
    init () {
        //print("Don't instantiate the base class!")
    }
    
    
    func Attack(tower : TowerBase) {
        //print("Don't call Attack() on the base class!")
    }
    
    func Die(tower : TowerBase) {
        //print("Don't call Die() on the base class!")
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
//    func setParent(parent : TowerBase) {
//        self.parent = parent
//    }
//    func getParent() -> TowerBase {
//        return self.parent!
//    }
//    func setExplosionLevel(level : Int) {}
//    func setHomingLevel(level : Int) {}
    
    
}