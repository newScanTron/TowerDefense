//
//  TowerAttackPulse.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/29/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//


import Foundation
import SpriteKit

class TowerAttackPulse : TowerAttackStrat {
    
    var lastFire : CGFloat = 0
    
    override init () {
        super.init()
        imageName = "pulseTop"
        self.setRangeLevel(0)
        self.setDamageLevel(0)
        self.setFireDelayLevel(0)
    }
    
    override func setRangeLevel(level : Int) {
        rangeLevel = level
        range = 75 + CGFloat(level) * 50
    }
    
    override func setDamageLevel(level : Int) {
        damageLevel = level
        damage = 20 + CGFloat(level) * 5
    }
    
    override func setFireDelayLevel(level : Int) {
        fireDelayLevel = level
        fireDelay = 3/CGFloat(level+1)
    }
    
    override func copy() -> TowerAttackPulse {
        let strat = TowerAttackPulse()
        strat.setRangeLevel(rangeLevel)
        strat.setDamageLevel(damageLevel)
        strat.setFireDelayLevel(fireDelayLevel)
        strat.setSpeedLevel(speedLevel)
        return strat
    }
    
    
    override func Die(tower : TowerBase)  {
        
    }
    
    override func Attack(tower : TowerBase) {
        if (GameScene.gameTime > lastFire + fireDelay) {
            // Start new pulse
            lastFire = GameScene.gameTime
            Explosion(_radius: range, _damage: damage).trigger(tower.sprite.position)
            
        }
    }
}