//
//  File.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/1/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation

class TowerAttackBasic : TowerAttackStrat {
    
    var lastFire : Float = 0

    
    override init () {}
    
    override func Attack() {
        
        if (GameScene.gameTime > lastFire + fireDelay) {
            lastFire = GameScene.gameTime
            if (parent != nil) {
                target = GameScene.getClosestEnemy(parent!.sprite.position)
                Bullet(
                    start: parent!.sprite.position,
                    _target: target!.sprite.position,
                    _damage: damage,
                    _speed: speed,
                    _tower: &parent!
                )
            }
        }
        
        
    }
    
}

