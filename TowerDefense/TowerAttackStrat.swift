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
    var bullet : Bullet? = nil
    var target : EnemyBase? = nil
    var parent : TowerBase? = nil
    
    var rangeLevel : Int = 0
    var damageLevel : Int = 0
    var fireDelayLevel : Int = 0
    var speedLevel : Int = 0
    
    init () {
        //print("Don't instantiate the base class!")
    }
    
    
    func Attack() {
        //print("Don't call Attack() on the base class!")
    }
    
    func Die() {
        //print("Don't call Die() on the base class!")
    }
    func setRangeLevel(level : Int) {}
    func setDamageLevel(level : Int) {}
    func setFireDelayLevel(level : Int) {}
    func setSpeedLevel(level : Int) {}
//    func setExplosionLevel(level : Int) {}
//    func setHomingLevel(level : Int) {}
    
    
}