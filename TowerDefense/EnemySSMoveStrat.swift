//
//  EnemySSMoveStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 3/6/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation

class EnemySSMoveStrat: EnemyMoveStrat{
    
    var moveTo = SideScrolScene.scene?.shipSprite.position
    
    override func Move(enemy : EnemyBase){
        let vector = getVector(enemy.sprite.position, to: SideScrolScene.scene!.shipSprite.position, speed: 20)
        
        if enemy.sprite.position.x < moveTo?.x {
            enemy.sprite.physicsBody?.velocity.dx = 0
            enemy.sprite.physicsBody?.velocity.dy = 0
            
            if enemy.sprite.physicsBody?.velocity.dx == 0{
                enemy.sprite.physicsBody?.velocity.dx = 10
                enemy.sprite.physicsBody?.velocity.dy = 190
                
            }
        }
        else {
            if enemy.sprite.physicsBody?.velocity.dx < 3 {
                enemy.sprite.physicsBody?.applyImpulse(vector)
            }
        }
    }
    
}