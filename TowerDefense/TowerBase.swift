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
    var health = 100
    var sprite : SKSpriteNode
    var attack : TowerAttackStrat
    var defense : TowerDefenseStrat
    var kills : Int = 0
    var healed : Int = 0
    
    init (location: CGPoint, _attack : TowerAttackStrat, _defense :TowerDefenseStrat )
    {
        sprite = SKSpriteNode(imageNamed: "Sat2")
        
        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.position = location
        sprite.size = CGSizeMake(47, 47)
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Tower
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Tower
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Tower
        sprite.physicsBody?.categoryBitMask = BodyType.Tower.rawValue
        sprite.physicsBody?.dynamic = true
        
        //let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:5)
        
        //sprite.runAction(SKAction.repeatActionForever(action))
        
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