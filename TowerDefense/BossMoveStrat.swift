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

    //Instance variables
    var lastMove : CGFloat = 0
    //var bossNode : EnemyBase! = nil
    var target : [TowerBase] = [TowerBase]()
    var setEnemies : Bool = false
    
    override func Move(enemy : EnemyBase){

        //offSet keeps the sprite using this strategy in the field of view
        let offSet : CGFloat = 150
        //bossNode = nodeToMove
        
        target = GameScene.getTowersInRange(enemy.sprite.position, range: 150)
        
        //Determines sprite position and sets out of bounds or if there is near by target
        if (enemy.sprite.position.x >= GameScene.scene!.size.width - offSet || enemy.sprite.position.x <= 0 + offSet || enemy.sprite.position.y >= GameScene.scene!.size.height - offSet || enemy.sprite.position.y <= 0 + offSet){
            outOfBounds(enemy)
        }
        else {
            enemy.sprite.physicsBody?.linearDamping = 0.0

            //If there are tower targets the sprite will move towards them
            if target.isEmpty{
                enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYRand()))
            }
            else {
                for t in target{
                    enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: t.sprite.position, speed: 2))
                }
            }
        }
        
        // Changes enemy move strategy to the Swarm strategy
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
}
