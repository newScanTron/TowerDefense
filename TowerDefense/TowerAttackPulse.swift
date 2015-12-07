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
    
//    var pulsing : Bool = false
//    
//    var currentRadius : CGFloat = 0
//    var currentDamage : CGFloat = 0
//    var circle : SKShapeNode?
    
    
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
//        circle?.removeFromParent()
//        circle = nil
    }
    
    override func Attack(tower : TowerBase) {
                if (GameScene.gameTime > lastFire + fireDelay) {
                    // Start new pulse
                    lastFire = GameScene.gameTime
                    Explosion(_radius: range, _damage: damage).trigger(tower.sprite.position)
                        
                }
    }
        
//        
//        // If time since last pulse has passed
//        if (!pulsing && GameScene.gameTime > lastFire + fireDelay) {
//            // Start new pulse
//            lastFire = GameScene.gameTime
//            pulsing = true
//            currentRadius = 0
//                
//        }
//        
//
//        
//        if (pulsing) {
//            // If pulse's current radius has exceeded range
//            if (currentRadius > (range)) {
//                // End pulse
//                pulsing = false
//                circle?.removeFromParent()
//            }
//            // If pulse's current radius has not exceeded range
//            else {
//                // Grow current radius by speed
//                currentRadius += speed
//                
//                // Ratio for pulses progress
//                let ratio : CGFloat = (1-(currentRadius/(range)))
//                
//                // Linearly decreasing damage
//                currentDamage = ratio * damage
//                
//                for e in GameScene.getEnemiesInRange(parent!.sprite.position,range: currentRadius) {
//                    // Apply damage to each enemy within pulse
//                    e.health -= currentDamage
//                }
//                
//                
//                // Remove old circle
//                circle?.removeFromParent()
//                // Create new circle
//                circle = SKShapeNode(circleOfRadius: currentRadius)
//                circle?.position = parent!.sprite.position
//                circle?.lineWidth = 1.0;
//                
//                // Color fades as pulse progresses
//                circle?.fillColor = SKColor(red: 0, green: 0, blue: 1, alpha: 1 * ratio)
//                circle?.strokeColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1 * ratio*2)
//                
//                circle?.glowWidth = 0.5;
//                circle?.zPosition = ZPosition.tower-1
//                circle?.blendMode = SKBlendMode.Screen
//                
//                // Add circle back to scene
//                GameScene.scene?.addChild(circle!)
//                
//
//            }
//        }
//        
//        
//        
//    }
    
}