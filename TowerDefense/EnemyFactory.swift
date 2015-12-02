//
//  EnemyFactory.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyFactory
{

    var enemyCount : CGFloat = 0
    init(){}
    
    func getNextEnemy() -> EnemyBase? {
        
        var enemy :EnemyBase? = nil
        
            if(enemyCount <= 9){
                enemy = CreateEnemy()
                enemyCount++
                return enemy!
            }
            if(enemyCount > 9 && enemyCount < 14){
                enemy = CreateEnemyGrunt()
                enemyCount++
                return enemy!
            }
            if(enemyCount == 14){
                enemy = CreateEnemyBoss()
                enemyCount++
                return enemy!
            }
            else {
                return nil
        }
    }
    
    func CreateEnemy() -> EnemyBase{
        
        let attack = RangedAttack()
        let moveStrat = ConcreteMoveStrat1()
        let range: CGFloat = 250.00
        
        attack.damage = 3
        attack.fireDelay = 1
        attack.speed = 100
        let moveDelay : CGFloat = 1.5
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")

        sprite.size = CGSizeMake(100, 100)
        
        let reward = 100
        
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward)

        enemy.health = 300
        return enemy
    }
    func CreateEnemyBoss() -> EnemyBase{
        
        let attack = GruntAttack()
        let moveStrat = BossMoveStrat()
        let range: CGFloat = 9999.00
        attack.damage = 3
        attack.fireDelay = 1
        attack.speed = 100
        let moveDelay :CGFloat = 99.0
        let bossName : String = "Boss"
        
        let sprite = SKSpriteNode(imageNamed: bossName)

        sprite.size = CGSizeMake(300, 300)
        sprite.name = bossName
    
        let reward = 500

        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward)
        enemy.health = 600

        return enemy
        
    }
    func CreateEnemyGrunt() -> EnemyBase{
        
        let attack = RangedAttack()
        let moveStrat = ConcreteMoveStrat2()
        let range: CGFloat = 200.00
        attack.damage = 3
        attack.fireDelay = 1
        attack.speed = 100
        var moveDelay : CGFloat = 99.0
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")

        sprite.size = CGSizeMake(100, 100)
        
        let reward = 100
        
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward)
        enemy.health = 300
        return enemy
    }

}
