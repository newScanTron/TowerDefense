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
    
    init () {
        //fatalError("Don't instantiate the base class!")
    }

    func Attack(enemy: EnemyBase, scene: SKScene, target: CGPoint){
        
    }
}