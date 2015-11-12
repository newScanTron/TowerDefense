//
//  EnemyAttackStrat.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyAttackStrat
{
    var damage : Int = 0
    var fireDelay : Float = 0
    var speed : Float = 0
    var bullet : EnemyBullet? = nil
    var target : TowerBase? = nil
    var parent : EnemyBase? = nil
    var enemyAngle : CGFloat = 0
    
    init () {
        //fatalError("Don't instantiate the base class!")
    }

    func Attack(enemy: EnemyBase){
        
    }
    func rotateTowardTarget(enemy: EnemyBase){
        var angle : CGFloat
        let target : TowerBase? = GameScene.getClosestTower(enemy.sprite.position)
        
        if GameScene.towers.count > 0 {
            if target?.sprite.parent != nil{
                if(GameScene.getDistance(enemy.sprite.position, to: target!.sprite.position) <= enemy.range){
                    // Calculate the angle using the relative positions of the enemy sprite and closest tower.
                    angle = atan2(enemy.sprite.position.y - target!.sprite.position.y, enemy.sprite.position.x - target!.sprite.position.x)
                    angle -= enemyAngle
                    let action = SKAction.rotateByAngle(angle, duration:0.125)
                    enemyAngle += angle
                    enemy.sprite.runAction(SKAction.repeatAction(action, count: 1))
                    
                }
            }
        }

    }
}