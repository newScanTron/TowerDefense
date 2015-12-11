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
    //Instance variable
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
                    waveDelay = 15.0
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
        let moveStrat = EnemyMoveBasic()
        let range: CGFloat = 250.00
        let moveDelay : CGFloat = 0.5
        let name = "RangedSprite"
        let sprite = SKSpriteNode(imageNamed: "Spaceship")
        let reward = 100
        

        //Set attack variables
        attack.damage = 0.5

        attack.fireDelay = 1
        attack.speed = 300
        
        sprite.size = CGSizeMake(100, 100)
        sprite.zPosition = ZPosition.enemy

        //Instantiate enemy object
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward, _name: name)

        //Set enemy specific health
        enemy.health = 150
        enemy.maxHealth = 150
        
        //return the object to the GameScene
        return enemy
    }
    //Enemy Boss creation
    func CreateEnemyBoss() -> EnemyBase{
        
        //Set enemy strategies and variables
        let attack = EnemyAttackBoss()
        let moveStrat = EnemyMoveBoss()
        let range: CGFloat = 999.00
        let moveDelay :CGFloat = 1.0
        let name = "BossSprite"
        let reward = 500
    
        //Set attack variables
        attack.damage = 2
        attack.fireDelay = 1
        attack.speed = 200

        let sprite = SKSpriteNode(imageNamed: name)
        sprite.zPosition = ZPosition.enemy+1

        sprite.size = CGSizeMake(300, 300)
        sprite.name = name
    
        //Instantiate enemy object
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward, _name: name)
        
        //Set object specific variables
        enemy.health = 175
        enemy.maxHealth = 175
        
        //Return object to the GameScene
        return enemy
    }
    //Grunt enemy with Ranged attack
    func CreateEnemyGrunt() -> EnemyBase{
        
        //Set enemy strategies and variables
        let attack = EnemyAttackRanged()
        let moveStrat = EnemyMoveKamikaze()
        let range: CGFloat = 200.00
        var moveDelay : CGFloat = 1.0
        let name = "GruntSprite"
        let reward = 100
        
        //Set attack variables
        attack.damage = 0.5
        attack.fireDelay = 1
        attack.speed = 300

        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")

        sprite.size = CGSizeMake(100, 100)
        sprite.zPosition = ZPosition.enemy

        //Instantiate enemy object
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward, _name: name)
        
        //Set object specific variables
        enemy.health = 100
        enemy.maxHealth = 100
        
        //Return object to the GameScene
        return enemy
    }

}
