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
    
    //Set instance variable
    var lastMove : CGFloat = 0
    
    override func Move(enemy : EnemyBase) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        //Causes all sprites with this strategy to circle the boss
        for e in appDelegate!.gameScene!.enemies{
            
            //Finds the boss for the target
            if e.name == "BossSprite"{
                
                //Three states that keep the sprite close to the boss
                //Distance are > 250, 75 - 250 and < 75 is the else
                if getDistance(enemy.sprite.position, to: e.sprite.position) > CGFloat(250){
                    enemy.sprite.physicsBody?.linearDamping = 0.75
                    enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: e.sprite.position, speed: 9.0))
                }
                else if getDistance(enemy.sprite.position, to: e.sprite.position) > CGFloat(75) && getDistance(enemy.sprite.position, to: e.sprite.position) < 250 {
                    enemy.sprite.physicsBody?.linearDamping = 0.5
                    enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: e.sprite.position, speed: 8.0))
                }
                else {
                    enemy.sprite.physicsBody?.linearDamping = 0
                    enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: e.sprite.position, speed: 20.0))
                }
            }
        }
    }
}