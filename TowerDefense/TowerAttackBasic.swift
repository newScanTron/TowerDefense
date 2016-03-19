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
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var lastFire : CGFloat = 0
    
    var expLevel : Int = 0 //
    var expOn : Bool = false
    var expForce : CGFloat = 0
    
    var homingLevel : Int = 0
    var homingOn : Bool = false
    
    var outRangeColor : SKColor = SKColor(red: 1, green: 1, blue: 1, alpha : 0.3)
    var inRangeColor : SKColor = SKColor(red: 1, green: 1, blue: 1, alpha : 0.6)
    
    
    var circle : SKShapeNode?
    
    
    override init () {
        
        
        super.init()
        imageName = "cannonTop"
        self.setRangeLevel(0)
        self.setDamageLevel(0)
        self.setSpeedLevel(0)
        self.setFireDelayLevel(0)
        self.setExplosionLevel(0)
        self.setHomingLevel(0)
        
        
        
    }
    
    override func setRangeLevel(level : Int) {
        rangeLevel = level
        range = 100 + CGFloat(level) * 75
        // removes old visualization circle
        circle?.removeFromParent()
        circle = nil
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
            expForce = 1 + CGFloat(expLevel)
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
    
    override func Die(tower : TowerBase) {
        circle?.removeFromParent()
        circle = nil
    }
    
    override func copy() -> TowerAttackBasic {
        // returns a copy of htis strategy
        let strat = TowerAttackBasic()
        strat.setRangeLevel(rangeLevel)
        strat.setDamageLevel(damageLevel)
        strat.setFireDelayLevel(fireDelayLevel)
        strat.setSpeedLevel(speedLevel)
        strat.setExplosionLevel(expLevel)
        strat.setHomingLevel(homingLevel)
        return strat
    }
    
    override func Attack(tower : TowerBase) {
        
        // If our visualization circle is missing...
        if (circle == nil) {
            // Create new circle
            circle = SKShapeNode(circleOfRadius: range)
            circle?.position = tower.sprite.position
            circle?.lineWidth = 2;
            circle?.strokeColor = outRangeColor
            circle?.glowWidth = 0;
            circle?.zPosition = ZPosition.tower-1
            circle?.blendMode = SKBlendMode.Screen
            
            // Add circle to scene
            GameScene.scene?.addChild(circle!)
        }
        
        
        // If enough time has passed since our last fire
        if (appDelegate.gameScene!.gameTime > lastFire + fireDelay) {
            lastFire = appDelegate.gameScene!.gameTime
            target = getClosestEnemy(tower.sprite.position, range: range)
            
            // If a target was found...
            if (target != nil) {
                
                // Change visualization circle to indicate an enemy was found
                circle?.strokeColor = inRangeColor
                circle?.glowWidth = 3;
                
                // Instantiate bullet
                let b : Bullet = Bullet(_shooter: tower, _target: target!.sprite, _speed: speed, _damage: damage, size: 15, shotByEnemy: false)
                if (expOn) {
                    b.setExplosion(expForce)
                }
                if (homingOn) {
                    b.setHoming(true, _homingForce: 5)
                }
            }
            else {
                circle?.strokeColor = outRangeColor
                circle?.glowWidth = 0;
            }
            
            
        }
        
        
    }
    
}



