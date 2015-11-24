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
    init(){}
    
    func CreateEnemy(scene: SKScene) -> EnemyBase{
        
        let attack = RangedAttack()
        let moveStrat = ConcreteMoveStrat1()
        let range: CGFloat = 200.00
        
        attack.damage = 40
        attack.fireDelay = 1
        attack.speed = 10
        let moveDelay : CGFloat = 1.5
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")

        sprite.size = CGSizeMake(100, 100)
        
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay)

        return enemy
    }
    func CreateEnemyBoss(scene: SKScene) -> EnemyBase{
        
        let attack = RangedAttack()
        let moveStrat = BossMoveStrat()
        let range: CGFloat = 350.00
        attack.damage = 50
        attack.fireDelay = 1
        attack.speed = 10
        let moveDelay :CGFloat = 99.0
        let name : String = "Boss"
        
        let sprite = SKSpriteNode(imageNamed: "EnemyBoss")

        sprite.size = CGSizeMake(100, 100)
        sprite.name = "Boss"
        
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay)
 
        return enemy
        
    }
    func CreateEnemyGrunt(scene: SKScene) -> EnemyBase{
        
        let attack = RangedAttack()
        let moveStrat = ConcreteMoveStrat2()
        let range: CGFloat = 200.00
        attack.damage = 40
        attack.fireDelay = 1
        attack.speed = 10
        var moveDelay : CGFloat = 99.0
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")

        sprite.size = CGSizeMake(100, 100)        
        
        let enemy = EnemyBase(_attack: attack, _moveStrat: moveStrat, _sprite: sprite, _range: range, _moveDelay: moveDelay)
 
        return enemy
    }

}
