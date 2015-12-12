//
//  EnemyAttackBoss.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyAttackBoss: EnemyAttackStrat{
    
    //Set instance variable
    var lastFire : CGFloat = 0
    var circle : SKShapeNode? = nil
    var healingTarget = [EnemyBase]()
    let color = SKColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 10)
    var allHealthy = false
    var healthCount = 0
    
    //Die function that cleans up boss death
    override func Die()  {
        circle?.removeFromParent()
        circle = nil
        for e in GameScene.enemies{
            e.isImmune = false
            e.sprite.physicsBody?.linearDamping = 0.0


            e.setMoveStrategy(EnemyMoveBasic())

        }
        
        let exp : Explosion = Explosion(_radius: 1000, _damage: 80)
        exp.trigger(parent!.sprite.position)
        

    }
    
    //Boss attack strategy that heals enemies and gives them immunity if 
    //they're in range. Also changes cricle color depending on whether its
    //healing or dealing damage
    override func Attack(){
        
        healthCount = 0
        healingTarget = getEnemiesInRange(parent!.sprite.position, range: 125)
        
        //Loop determing if there are injured enemies or not and setting flags 
        //appropriately
        for e in GameScene.enemies {
            if e.name == "BossSprite" {

            }
            else if getDistance(parent!.sprite.position, to: e.sprite.position) <= 150 {
                if e.health < e.maxHealth{
                    allHealthy = false
                    e.health += 1
                    healthCount++
                    e.UpdateLabel()
                }
                e.isImmune = true
            }
            else {
                e.isImmune = false
            }
        }
        if healthCount == 0{
            allHealthy = true
        }
        //Circle creation
        circle?.removeFromParent()
        circle = SKShapeNode(circleOfRadius: 125.0)
        
        circle?.position = parent!.sprite.position
        
        circle?.lineWidth = 0.0;
        
        // Color changes based on whether there are enemies to heal or not
        if (allHealthy) {
            circle?.fillColor = SKColor(red: 1, green: 0, blue: 0, alpha: 0.3)
            circle?.strokeColor = SKColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        }
        else {
            circle?.fillColor = SKColor(red: 0, green: 1, blue: 0, alpha: 0.3)
            circle?.strokeColor = SKColor(red: 0, green: 1, blue: 0, alpha: 0.3)
        }
        circle?.glowWidth = 0.5;
        circle?.zPosition = ZPosition.enemy
        circle?.blendMode = SKBlendMode.Screen
        if(parent!.sprite.position.x < 1000){
            GameScene.scene?.addChild(circle!)
        }

        /*if (allHealthy){
            parent!.setAttackStrategy(EnemyAttackBoss())
        }*/
    
    }
}


