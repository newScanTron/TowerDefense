//
//  EnemyMoveKamikaze.swift
//  TowerDefense
//
//  Created by My Macbook Pro on 12/10/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveKamikaze: EnemyMoveStrat{
    
    //Instance variable
    var lastMove : CGFloat = 0
    let offSet : CGFloat = 150
    var kamikazeSet : Bool = false
    let damage : CGFloat = 10
    
    //Continuously call the execute method passing the strategy
    // and sprite to be moved
    override func Move(enemy : EnemyBase){
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        enemy.name = "kamikaze"
        if enemy.health < enemy.maxHealth * 0.2{
        enemy.health = enemy.maxHealth + 500
            kamikazeSet = true
        }
        //Handles what strategy to use depending on the sprite position
        if !kamikazeSet{
            enemy.sprite.physicsBody?.linearDamping = 0.0
            
            if (enemy.sprite.position.y <= offSet){
                outOfBounds(enemy)
            }
            else if(enemy.sprite.position.y >= appDelegate!.gameScene!.size.height - offSet){
                outOfBounds(enemy)
            }
            else if (enemy.sprite.position.x < offSet){
                outOfBounds(enemy)
            }
            else if (enemy.sprite.position.x > appDelegate!.gameScene!.size.width - offSet) {
                outOfBounds(enemy)
            }
            else {
                enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYRand()))
            }
        }
        else {
            kamikaze(enemy)
        }
        
    }
    func stopSprite(enemy: EnemyBase){
        enemy.sprite.physicsBody?.linearDamping = 1
    }
    func kamikaze(enemy: EnemyBase){

        let towers = getClosestTower(enemy.sprite.position)
        if getDistance(enemy.sprite.position, to: towers!.sprite.position) <= 20 {
            Explosion(_radius: 100, _damage: 10).trigger(enemy.sprite.position)
            enemy.health = 0
        }
        enemy.sprite.physicsBody?.applyImpulse(getVector(enemy.sprite.position, to: towers!.sprite.position, speed: 35))

    }
}
