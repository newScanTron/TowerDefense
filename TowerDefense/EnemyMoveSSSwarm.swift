//
//  EnemyMoveSSSwarm.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 4/10/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveSSSwarm : EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase) {
        let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate
        for e in appDelegate!.sideScrollScene!.enemies{
            
            if e.name == "BossSprite"{
                
                if getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(250){
                    nodeToMove.sprite.physicsBody?.linearDamping = 0.75
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: e.sprite.position, speed: 9.0))
                }
                else if getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(75) && getDistance(nodeToMove.sprite.position, to: e.sprite.position) < 250 {
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
}