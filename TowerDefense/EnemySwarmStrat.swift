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
    
    override func Move(nodeToMove : EnemyBase) {
        
        
        if nodeToMove.name != "BossSprite"{
            for e in GameScene.enemies{
                
                if e.name == "BossSprite"{
                    
                    if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(250){
                        nodeToMove.sprite.physicsBody?.linearDamping = 0.75
                        nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: e.sprite.position, speed: 9.0))
                    }
                    else if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(75) && GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) < 250 {
                        nodeToMove.sprite.physicsBody?.linearDamping = 0.5
                        nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: e.sprite.position, speed: 8.0))
                    }
                    else {
                        nodeToMove.sprite.physicsBody?.linearDamping = 0
                        nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: e.sprite.position, speed: 20.0))
                    }
                }
            }
        }
        else {
            nodeToMove.setMoveStrategy(EnemyMoveBoss())
        }
    }
}