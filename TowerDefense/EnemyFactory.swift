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
    var enemyClone : EnemyBase? = nil
    
    init(){
        enemyClone = CreateEnemy()
    }
    
    // Decides what enemy and how many to return to the GameScene
    func getNextEnemy() -> EnemyBase? {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        var enemy :EnemyBase? = nil
        
        if appDelegate.gameScene!.gameTime > lastEnemy + waveDelay{
            lastEnemy = appDelegate.gameScene!.gameTime
            
            if(enemyCount <= (9 + theWave)){
                enemy = CreateEnemyTowerDefense()
                waveDelay = 2.0
                enemyCount++
                return enemy!
            }
            if(enemyCount > (9 + theWave) && enemyCount <= (14 + theWave))
            {
                waveDelay = 0.2
                enemy = CreateEnemyGrunt()
                if enemyCount == 14 {
                    waveDelay = 15.0
                }
                enemyCount++
                return enemy!
            }
            if(enemyCount > (14 + theWave) && enemyCount <= (15 + theWave))
            {
                waveDelay = 15.0
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
    func CreateEnemyTowerDefense() -> EnemyBase{
        
        
        
        let attack = EnemyAttackRanged()
        let moveStrat = EnemyMoveBasicTowerDefense()
        let range: CGFloat = 250.00
        
        attack.damage = 5.5
        attack.fireDelay = 1
        attack.speed = 300
        
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
    //Enemy with Ranged attack strategy
    func CreateEnemy() -> EnemyBase{
        

        
        let attack = EnemyAttackRanged()
        let moveStrat = EnemyMoveBasic()
        let range: CGFloat = 250.00
        
        attack.damage = 5.5
        attack.fireDelay = 1
        attack.speed = 300

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
        let moveDelay : CGFloat = 1.0
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
    func getNextSSEnemy() -> EnemyBase {
        let enemy :EnemyBase? = getSSEnemy()
        return enemy! 
    }
    func getObstacle() -> EnemyBase? {
        
        
        //Set enemy strategies and variables
        let attack = EnemyAttackObstacle()
        let moveStrat = EnemyMoveObstacle()
        let range: CGFloat = 200.00
        let moveDelay : CGFloat = 1.0
        let name = "GruntSprite"
        let reward = 100
        var intro : Bool = false
        
        //Set attack variables
        attack.damage = 0.5
        attack.fireDelay = 1
        attack.speed = 300
        
        let sprite = SKSpriteNode(imageNamed: "bullet")
        let size = random(min: 15, max: 40)
        var speed = random(min:-40 , max:-120)
        
        sprite.size = CGSizeMake(size, size)
        sprite.zPosition = ZPosition.enemy
        
        
        //Instantiate enemy object
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay, _reward: reward, _name: name)
        
        if SideScrolScene.scene!.intro == false {
            speed = random(min: -440, max: -520)
            sprite.physicsBody?.velocity.dx = speed
            if SideScrolScene.scene?.deltaTime > 239 {
                intro = true
                for (var i = 0; i < SideScrolScene.enemies.count; i++)
                {
                    let e = SideScrolScene.enemies[i]
                    e.sprite.physicsBody?.velocity.dx += 200
                }
            }
        }
        else{
            sprite.physicsBody?.velocity.dx = speed
        }
        
        
        //Set object specific variables
        enemy.health = 100
        enemy.maxHealth = 100
        
        //Return object to the GameScene
        return enemy
    }
    func getSSEnemy() -> EnemyBase? {
        //Set enemy strategies and variables
        let attack = EnemyAttackRanged()
        let moveStrat = EnemySSMoveStrat()
        let range: CGFloat = 200.00
        let moveDelay : CGFloat = 1.0
        let name = "GruntSprite"
        let reward = 100
        
        //Set attack variables
        attack.damage = 0.5
        attack.fireDelay = 1
        attack.speed = 300
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")
        
        sprite.size = CGSizeMake(90, 90)
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
