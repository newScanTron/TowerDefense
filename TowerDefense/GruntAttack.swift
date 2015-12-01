//
//  GruntAttack.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class GruntAttack: EnemyAttackStrat{
    
    var lastFire : CGFloat = 0
    
    override init(){}
    
    override func Attack(){
        
        
        if (GameScene.gameTime > lastFire + fireDelay) {
            
            lastFire = GameScene.gameTime
            if (parent != nil) {
                target = GameScene.getClosestTower(parent!.sprite.position)

                var bulletParent : Entity = parent!
    
                Bullet(
                    _start: parent!.sprite.position,
                    _target: target!.sprite.position,
                    _speed: speed,
                    _damage: damage,
                    _entity: &bulletParent,
                    _explosion: nil,
                    _shotByEnemy: true
                )
                
            }
        }
        

    }
}
