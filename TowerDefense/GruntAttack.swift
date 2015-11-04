//
//  GruntAttack.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class GruntAttack: EnemyAttackStrat{
    
    var range : Int = 0
    var damage : Int = 0
    var fireDelay : Float = 0
    var speed : Float = 0
    var bullet : Bullet? = nil
    var target : TowerBase? = nil
    var parent : EnemyBase? = nil
    
    init(){}
    
    func Attack(e: EnemyBase, t: SKNode, s: SKScene){
        
    }
}
