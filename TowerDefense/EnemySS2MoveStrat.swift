//
//  EnemySS2MoveStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 3/25/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemySS2MoveStrat: EnemyMoveStrat{
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    override func Move(enemy : EnemyBase){
        
        enemy.sprite.physicsBody?.velocity.dx = -160
        if enemy.sprite.position.x < (appDelegate!.sideScrollScene!.size.width - 100) {
            enemy.sprite.physicsBody?.velocity.dx = 0
            enemy.sprite.physicsBody?.velocity.dy = 0
        }
        
        if enemy.sprite.position.x < (appDelegate!.sideScrollScene!.size.width - 100) && enemy.sprite.physicsBody?.velocity.dx == 0{
            enemy.sprite.physicsBody?.velocity.dy = -120
            
        }
        if enemy.sprite.position.y < 100 {
            enemy.setMoveStrategy(EnemySSMoveStrat())
        }
    }
}
