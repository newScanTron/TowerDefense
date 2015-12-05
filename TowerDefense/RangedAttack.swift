//
//  RangedAttack.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit


class RangedAttack: EnemyAttackStrat{
    
    var lastFire : CGFloat = 0

    override init(){}
    
    override func Attack() {
        
        if (GameScene.gameTime > lastFire + fireDelay) {
    
            lastFire = GameScene.gameTime
            if (parent != nil) {
                if(GameScene.towers.count > 0){
                    let t = GameScene.getTowersInRange(parent!.sprite.position, range: parent!.range)
                    if t.isEmpty{}
                    else{target = t.first
                    
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
    }
}
