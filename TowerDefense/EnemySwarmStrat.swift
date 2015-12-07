//
//  EnemyMoveSwarm.swift
//  TowerDefense
//
//  Created by My Macbook Pro on 12/2/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveSwarm : EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
    
    override func Move(enemy : EnemyBase) {
        
        
        if enemy.name != "BossSprite"{
            for e in GameScene.enemies{
                
                if e.name == "BossSprite"{
                    
                    if GameScene.getDistance(enemy.sprite.position, to: e.sprite.position) > CGFloat(250){
                        enemy.sprite.physicsBody?.linearDamping = 0.75
                        enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: e.sprite.position, speed: 9.0))
                    }
                    else if GameScene.getDistance(enemy.sprite.position, to: e.sprite.position) > CGFloat(75) && GameScene.getDistance(enemy.sprite.position, to: e.sprite.position) < 250 {
                        enemy.sprite.physicsBody?.linearDamping = 0.5
                        enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: e.sprite.position, speed: 8.0))
                    }
                    else {
                        enemy.sprite.physicsBody?.linearDamping = 0
                        enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: e.sprite.position, speed: 20.0))
                    }
                }
            }
        }
        else {
            enemy.setMoveStrategy(EnemyMoveBoss())
        }
    }
}