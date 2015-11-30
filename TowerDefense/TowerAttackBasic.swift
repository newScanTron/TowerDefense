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

    
    override init () {}
    
    override func Attack() {

        
        
        if (GameScene.gameTime > lastFire + fireDelay) {

            
            lastFire = GameScene.gameTime
            if (parent != nil) {
                target = GameScene.getClosestEnemy(parent!.sprite.position)
                if (target != nil) {
                    var bulletParent : Entity = parent!
                    print("FIRE")
                    Bullet(
                        _start: parent!.sprite.position,
                        _target: target!.sprite.position,
                        _speed: speed,
                        _damage: damage,
                        _entity: &bulletParent,
                        _shotByEnemy: false)
                }
                
            }
        }
        
        
    }
    
}



