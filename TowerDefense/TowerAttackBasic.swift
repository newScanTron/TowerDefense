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
    
    var expLevel : Int = 0
    var expOn : Bool = false
    var expForce : CGFloat = 0
    
    var homingLevel : Int = 0
    var homingOn : Bool = false
    
    var outRangeColor : SKColor = SKColor(red: 1, green: 1, blue: 1, alpha : 0.3)
    var inRangeColor : SKColor = SKColor(red: 1, green: 1, blue: 1, alpha : 0.6)
    
    //var bullet : Bullet?
    
    
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
    
    
//    override func setParent(parent: TowerBase) {
//        if (bullet == nil) {
//            bullet = Bullet(_shooter: parent, _target: parent.sprite, _speed: speed, _damage: damage, size: parent.sprite.size.height, shotByEnemy: false)
//        }
//        bullet?.shooter = parent
//        self.parent = parent
//    }
    
    override func setRangeLevel(level : Int) {
        rangeLevel = level
        range = 100 + CGFloat(level) * 75
        circle?.removeFromParent()
        circle = nil
    }
    
    override func setDamageLevel(level : Int) {
        damageLevel = level
        damage = 25 + CGFloat(level) * 5
        //bullet!.damage = 25 + CGFloat(level) * 5
    }
    
    override func setFireDelayLevel(level : Int) {
        fireDelayLevel = level
        fireDelay = 3/CGFloat(level+1)
    }
    
    override func setSpeedLevel(level : Int) {
        speedLevel = level
        speed = 75 + 50 * CGFloat(level)
        //bullet!.speed = 75 + 50 * CGFloat(level)
    }
    
    func setExplosionLevel(level : Int) {
        expLevel = level
        if (expLevel > 0) {
            expOn = true
            expForce = 1 + CGFloat(expLevel)
            //bullet!.setExplosion(Explosion(_radius: 20 + expForce * 5, _damage: 25 + expForce * 3))
        }
        else {
            expOn = false
        }
    }
    
    func setHomingLevel(level : Int) {
        homingLevel = level
        if (homingLevel > 0) {
            homingOn = true
            //bullet!.setHoming(true, _homingForce: 5)
        }
        else {
            homingOn = false
            //bullet!.setHoming(false, _homingForce: 5)
        }
    }
    
    override func Die(tower : TowerBase) {
        circle?.removeFromParent()
        circle = nil
    }
    
    override func copy() -> TowerAttackBasic {
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
        
        
        
        if (GameScene.gameTime > lastFire + fireDelay) {
            
            
            lastFire = GameScene.gameTime
                target = GameScene.getClosestEnemy(tower.sprite.position, range: range)
                if (target != nil) {
                    circle?.strokeColor = inRangeColor
                    circle?.glowWidth = 3;
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



