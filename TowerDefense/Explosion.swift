//
//  Explosion.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/30/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class Explosion : Item {
    
    var radius : CGFloat
    var currentRadius : CGFloat = 0
    
    var damage : CGFloat
    var currentDamage : CGFloat
    
    var location : CGPoint?
    
    var circle : SKShapeNode?
    
    
    init(_radius : CGFloat, _damage : CGFloat) {
        
        radius = _radius
        
        damage = _damage
        currentDamage = damage
        
        
    }
    
    func trigger(_location : CGPoint) {
        //print("explosion trigger")
        location = _location
        GameScene.items.append(self)
    }
    
    override func update() -> Void {
        //print("explosion update")
        // If pulse's current radius has exceeded range
        if (currentRadius > (radius)) {
            // End pulse
            destroyThis = true
            circle?.removeFromParent()
        }
            // If pulse's current radius has not exceeded range
        else {
            // Grow current radius by speed
            currentRadius += 10
            
            // Ratio for pulses progress
            let ratio : CGFloat = (1-(currentRadius/(radius)))
            
            // Linearly decreasing damage
            currentDamage = ratio * damage
            
            for e in getEnemiesInRange(location!,range: currentRadius) {
                // Apply damage to each enemy within pulse
                e.health -= currentDamage
                e.sprite.physicsBody!.applyImpulse(Bullet.getVector(location!, to: e.sprite.position, speed: currentDamage * 2))
            }
            
            
            // Remove  circle
            circle?.removeFromParent()
            // Create new circle
            circle = SKShapeNode(circleOfRadius: currentRadius)
            circle?.position = location!
            circle?.lineWidth = 1.0;
            
            // Color fades as pulse progresses
            circle?.fillColor = SKColor(red: 0, green: 0, blue: 1, alpha: 1 * ratio)
            circle?.strokeColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1 * ratio*2)
            
            circle?.glowWidth = 0.5;
            circle?.zPosition = ZPosition.tower-1
            circle?.blendMode = SKBlendMode.Screen
            
            // Add circle back to scene
            GameScene.scene?.addChild(circle!)
        }
        
    }
    
}



