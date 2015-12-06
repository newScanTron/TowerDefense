//
//  File.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/1/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerAttackBasic : TowerAttackStrat {
    
    var lastFire : CGFloat = 0
    
    var expOn : Bool = false
    var expForce : CGFloat = 0
    var expLevel : Int = 0
    
    var homingOn : Bool = false
    var homingLevel : Int = 0
    
    
    
    override init () {
        super.init()
        self.setRangeLevel(0)
        self.setDamageLevel(0)
        self.setSpeedLevel(0)
        self.setFireDelayLevel(0)
        self.setExplosionLevel(0)
        self.setHomingLevel(0)
    }
    
    override func setRangeLevel(level : Int) {
        rangeLevel = level
        range = 100 + CGFloat(level) * 50
    }
    
    override func setDamageLevel(level : Int) {
        damageLevel = level
        damage = 25 + CGFloat(level) * 5
    }
    
    override func setFireDelayLevel(level : Int) {
        fireDelayLevel = level
        fireDelay = 3/CGFloat(level+1)
    }
    
    override func setSpeedLevel(level : Int) {
        speedLevel = level
        speed = 75 + 50 * CGFloat(level)
    }
    
    func setExplosionLevel(level : Int) {
        expLevel = level
        if (expLevel > 0) {
            expOn = true
            expForce = 4 + CGFloat(expLevel)
        }
        else {
            expOn = false
        }
    }
    
    func setHomingLevel(level : Int) {
        homingLevel = level
        if (homingLevel > 0) {
            homingOn = true
        }
        else {
            homingOn = false
        }
    }
    
    override func Attack() {
        
        
        
        if (GameScene.gameTime > lastFire + fireDelay) {
            
            
            lastFire = GameScene.gameTime
            if (parent != nil) {
                target = GameScene.getClosestEnemy(parent!.sprite.position, range: range)
                if (target != nil) {
                    let bulletParent : Entity = parent!
                    var b : Bullet = Bullet(_shooter: bulletParent,_target: target!.sprite,_speed: speed,_damage: damage,size: 15,shotByEnemy: false)
                    if (expOn) {
                        b.setExplosion(Explosion(_radius: 90 + expForce * 2, _damage: 45 + expForce))
                    }
                    if (homingOn) {
                        b.setHoming(homingOn,_homingForce: 5)
                    }
                }
                
            }
        }
        
        
    }
    
}



