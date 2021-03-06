//
//  EnemyAttackRanged.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit


class EnemyAttackRanged: EnemyAttackStrat{
    
    var lastFire : CGFloat = 0
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    //Enemy ranged attack strategy that uses the bullet class to attack towers
    override func Attack() {
        
        if (appDelegate!.gameScene!.gameTime > lastFire + fireDelay) {
    
            lastFire = appDelegate!.gameScene!.gameTime
            if (parent != nil) {
                if(appDelegate!.gameScene!.towers.count > 0){
                    let t = getTowersInRange(parent!.sprite.position, range: parent!.range)
                    if t.isEmpty{}
                    else{target = t.first
//                        bullet!.target = target!.sprite
//                        var b : Bullet = bullet!.copy()
//                        b.activate()
                    Bullet(_shooter: parent!, _target: target!.sprite, _speed: speed, _damage: damage, size: 15, shotByEnemy: true)
                
                        
                        

                    }
                }
            }
        }
    }

}
