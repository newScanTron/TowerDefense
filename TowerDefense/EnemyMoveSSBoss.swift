//
//  EnemyMoveSSBoss.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 4/10/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveSSBoss: EnemyMoveStrat {
    //Instance variables
    
    var lastMove : CGFloat = 0
    //var bossNode : EnemyBase! = nil
    var target : [TowerBase] = [TowerBase]()
    var setEnemies : Bool = false
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    override func Move(enemy : EnemyBase){
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        //offSet keeps the sprite using this strategy in the field of view
        let offSet : CGFloat = 150
        //bossNode = nodeToMove
        
        target = appDelegate!.sideScrollScene!.ships

        //Determines sprite position and sets out of bounds or if there is near by target
        if (enemy.sprite.position.x >= appDelegate!.sideScrollScene!.size.width - offSet || enemy.sprite.position.x <= 0 + offSet || enemy.sprite.position.y >= appDelegate!.sideScrollScene!.size.height - offSet || enemy.sprite.position.y <= 0 + offSet){
            outOfSSBounds(enemy)
            
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
                for e in appDelegate!.sideScrollScene!.enemies{
                    
                    if e.name != "BossSprite"{ // Skip boss
                        e.setMoveStrategy(EnemyMoveSSSwarm())
                        setEnemies = true
                    }
                }
            }
        }
    }
}

