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
        attack.range = 100
        attack.damage = 40
        attack.fireDelay = 1
        attack.speed = 10
        
        let moveStrat = ConcreteMoveStrat1()

        let enemy = EnemyBase(_attack: attack, _scene: scene, _moveStrat: moveStrat)
        enemy.sprite.zPosition = ZPosition.enemy
        //add the bison to the scene
        
        return enemy
    }
}
