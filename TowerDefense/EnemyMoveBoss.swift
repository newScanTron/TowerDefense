//
//  BossMoveStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/4/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveBoss: EnemyMoveStrat {
    
    var lastMove : CGFloat = 0
    var bossNode : EnemyBase! = nil
    var target : [TowerBase] = [TowerBase]()
    var setEnemies : Bool = false
    
    override func Move(nodeToMove : EnemyBase){

        let offSet : CGFloat = 150
        bossNode = nodeToMove
        
        if (parent != nil){
            target = GameScene.getTowersInRange(parent!.sprite.position, range: 150)
        }
        
        if (bossNode.sprite.position.x >= GameScene.scene!.size.width - offSet || bossNode.sprite.position.x <= 0 + offSet || bossNode.sprite.position.y >= GameScene.scene!.size.height - offSet || bossNode.sprite.position.y <= 0 + offSet){
            outOfBounds()
        }
        else {
            parent!.sprite.physicsBody?.linearDamping = 0.0

            if target.isEmpty{
                parent!.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYRand()))
            }
            else {
                for t in target{
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(parent!.sprite.position, to: t.sprite.position, speed: 2))
                }
            }
        }
        
        if !setEnemies {
            if nodeToMove.sprite.position.x < 1000{
                for e in GameScene.enemies{
                    if e.name != parent!.name {
                        e.setMoveStrategy(EnemyMoveSwarm())
                        setEnemies = true
                        
                    }
                }
            }
        }
    }

    func upwardSpiral(){
        bossNode.sprite.physicsBody?.linearDamping = 0
        bossNode.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYPos()))
    }
    func downwardSpiral(){
        
    }
}
