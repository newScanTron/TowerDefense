//
//  TowerBase.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/29/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerBase: Entity{
    var health = 0
    var sprite : SKSpriteNode
    var attack : TowerAttackStrat
    var defense : TowerDefenseStrat
    var kills : Int = 0
    var healed : Int = 0
    init (location: CGPoint, _attack : TowerAttackStrat, _defense :TowerDefenseStrat )
    {
        sprite = SKSpriteNode(imageNamed: "Sat2")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = location
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Tower
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.dynamic = true
        
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:5)
        
        sprite.runAction(SKAction.repeatActionForever(action))
        
        attack = _attack;
        defense = _defense;
        
        
    }
    
    // Triggers attack strategy Attack function
    func TriggerAttack() {
        attack.Attack()
    }
    
    // Triggers defense strategy Defend function
    func TriggerDefend() {
        defense.Defend()
    }
    
}