//
//  EnemySS3MoveStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 4/4/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemySS3MoveStrat: EnemyMoveStrat{

    override func Move(enemy : EnemyBase){
        
        
        if enemy.sprite.position.y < 0 {
            enemy.sprite.physicsBody?.velocity.dx = -50
            enemy.sprite.physicsBody?.velocity.dy = 300
        }
        if enemy.sprite.position.y > (SideScrolScene.scene!.size.height - 200) {
            enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(CGFloat(-10), CGFloat(-40)))
        }
    }
}