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
    
    var homingOn : Bool = false
    var homingForce : CGFloat = 0
    
    
    override init () {}
    
    override func Attack() {
        
        
        
        if (GameScene.gameTime > lastFire + fireDelay) {
            
            
            lastFire = GameScene.gameTime
            if (parent != nil) {
                target = GameScene.getClosestEnemy(parent!.sprite.position)
                if (target != nil) {
                    let bulletParent : Entity = parent!
                    var b : Bullet = Bullet(_shooter: bulletParent,_target: target!.sprite,_speed: speed,_damage: damage,size: 15,shotByEnemy: false)
                    if (expOn) {
                        b.setExplosion(Explosion(_radius: 90 + expForce * 10, _damage: 45 + expForce * 5))
                    }
                    if (homingOn) {
                        b.setHoming(homingOn,_homingForce: homingForce)
                    }
                }
                
            }
        }
        
        
    }
    
}



