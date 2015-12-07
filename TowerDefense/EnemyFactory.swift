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
    var waveDelay : CGFloat = 0
    var lastEnemy : CGFloat = 0
    var enemyCount : CGFloat = 0
    var theWave : CGFloat = 0
    init(){}
    
    // Decides what enemy and how many to return to the GameScene
    func getNextEnemy() -> EnemyBase? {
        
        var enemy :EnemyBase? = nil
        
        if GameScene.gameTime > lastEnemy + waveDelay{
            lastEnemy = GameScene.gameTime
            
            if(enemyCount <= (9 + theWave)){
                waveDelay = 2.0
                enemy = CreateEnemy()
                enemyCount++
                return enemy!
            }
            if(enemyCount > (9 + theWave) && enemyCount <= (14 + theWave))
            {
                waveDelay = 0.2
                enemy = CreateEnemyGrunt()
                if enemyCount == 13 {
                    waveDelay = 5.0
                }
                enemyCount++
                return enemy!
            }
            if(enemyCount > (14 + theWave) && enemyCount <= (15 + theWave))
            {
                waveDelay = 10.0
                enemy = CreateEnemyBoss()
                enemyCount++
                return enemy!
            }
        }
        return nil
    }
    
    //Reset the wave for next wave
    func nextWave(){
        enemyCount = 0.0
        theWave++
    }
    
    //Enemy with Ranged attack strategy
    func CreateEnemy() -> EnemyBase{
        
        let attack = EnemyAttackRanged()
        let moveStrat = ConcreteMoveStrat1()
        let range: CGFloat = 250.00
        
        attack.damage = 0.5
        attack.fireDelay = 1
        attack.speed = 300
        let moveDelay : CGFloat = 1.5
        let name = "RangedSprite"
        let sprite = SKSpriteNode(imageNamed: "Spaceship")

        sprite.size = CGSizeMake(100, 100)
        sprite.zPosition = ZPosition.enemy
        let reward = 100
        
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward, _name: name)

        enemy.health = 150
        enemy.maxHealth = 150
        return enemy
    }
    //Enemy Boss creation
    func CreateEnemyBoss() -> EnemyBase{
        
        let attack = EnemyAttackGrunt()
        let moveStrat = BossMoveStrat()
        let range: CGFloat = 999.00
        attack.damage = 2
        attack.fireDelay = 1
        attack.speed = 200
        let moveDelay :CGFloat = 1.0
        let name = "BossSprite"
        

        let sprite = SKSpriteNode(imageNamed: name)
        sprite.zPosition = ZPosition.enemy+1

        sprite.size = CGSizeMake(300, 300)
        sprite.name = name
    
        let reward = 500

        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward, _name: name)
        enemy.health = 175
        enemy.maxHealth = 175
        return enemy
    }
    //Grunt enemy with Ranged attack
    func CreateEnemyGrunt() -> EnemyBase{
        
        let attack = EnemyAttackRanged()
        let moveStrat = ConcreteMoveStrat1()
        let range: CGFloat = 200.00
        attack.damage = 0.5
        attack.fireDelay = 1

        attack.speed = 300
        var moveDelay : CGFloat = 1.0
        let name = "GruntSprite"

        let sprite = SKSpriteNode(imageNamed: "Spaceship")

        sprite.size = CGSizeMake(100, 100)
        sprite.zPosition = ZPosition.enemy
        let reward = 100
        
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward, _name: name)
        enemy.health = 100
        enemy.maxHealth = 100
        return enemy
    }

}
