//
//  EnemySSMoveStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 3/6/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation

class EnemySSMoveStrat: EnemyMoveStrat{
    
    var moveTo = SideScrolScene.scene?.ship?.sprite.position
    
    override func Move(enemy : EnemyBase){
        let vector = getVector(enemy.sprite.position, to: moveTo!, speed: 10)
        
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