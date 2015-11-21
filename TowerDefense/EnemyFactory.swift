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
        let range: CGFloat = 200.00
        attack.damage = 40
        attack.fireDelay = 1
        attack.speed = 10
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")
        
        let moveStrat = ConcreteMoveStrat1()

        let enemy = EnemyBase(_attack: attack, _scene: scene, _moveStrat: moveStrat, _sprite: sprite, _range: range)

        //add the bison to the scene
        
        return enemy
    }
    func CreateEnemyBoss(scene: SKScene) -> EnemyBase{
        
        let attack = RangedAttack()
        let range: CGFloat = 350.00

        attack.damage = 50
        attack.fireDelay = 1
        attack.speed = 10

        let moveStrat = BossMoveStrat()
        
        let sprite = SKSpriteNode(imageNamed: "EnemyBoss")
        
        let enemy = EnemyBase(_attack: attack, _scene: scene, _moveStrat: moveStrat, _sprite: sprite, _range: range)
        
        return enemy
        
    }
    func CreateEnemyGrunt(scene: SKScene) -> EnemyBase{
        
        let attack = RangedAttack()
        let range: CGFloat = 200.00
        attack.damage = 40
        attack.fireDelay = 1
        attack.speed = 10
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")
        
        let moveStrat = ConcreteMoveStrat2()
        
        let enemy = EnemyBase(_attack: attack, _scene: scene, _moveStrat: moveStrat, _sprite: sprite, _range: range)
        
        //add the bison to the scene
        
        return enemy
    }

}
