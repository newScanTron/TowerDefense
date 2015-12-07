//
//  EnemyMoveBoss.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/4/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveBoss: EnemyMoveStrat {
    
    var lastMove : CGFloat = 0
    //var bossNode : EnemyBase! = nil
    var target : [TowerBase] = [TowerBase]()
    var setEnemies : Bool = false
    
    override func Move(enemy : EnemyBase){

        let offSet : CGFloat = 150
        //bossNode = nodeToMove
        
        target = GameScene.getTowersInRange(enemy.sprite.position, range: 150)
        
        if (enemy.sprite.position.x >= GameScene.scene!.size.width - offSet || enemy.sprite.position.x <= 0 + offSet || enemy.sprite.position.y >= GameScene.scene!.size.height - offSet || enemy.sprite.position.y <= 0 + offSet){
            outOfBounds(enemy)
        }
        else {
            enemy.sprite.physicsBody?.linearDamping = 0.0

            if target.isEmpty{
                enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYRand()))
            }
            else {
                for t in target{
                    enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: t.sprite.position, speed: 2))
                }
            }
        }
        
        if !setEnemies {
            if enemy.sprite.position.x < 1000{
                for e in GameScene.enemies{
                    if e.name != enemy.name {
                        e.setMoveStrategy(EnemyMoveSwarm())
                        setEnemies = true
                        
                    }
                }
            }
        }
    }

//    func upwardSpiral(){
//        bossNode.sprite.physicsBody?.linearDamping = 0
//        bossNode.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYPos()))
//    }
//    func downwardSpiral(){
//        
//    }
}
