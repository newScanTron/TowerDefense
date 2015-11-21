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
    var attack : TowerAttackStrat
    var defense : TowerDefenseStrat
    var healed : Int = 0
    init (location: CGPoint, _attack : TowerAttackStrat, _defense :TowerDefenseStrat )
    {
        
        attack = _attack;
        defense = _defense;
        
        super.init()
        
        sprite = SKSpriteNode(imageNamed: "Sat2")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = location
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = CategoryMask.Tower
        sprite.physicsBody?.collisionBitMask = CollisionMask.Tower
        sprite.physicsBody?.contactTestBitMask = ContactMask.Tower

        sprite.physicsBody?.dynamic = false

        
        
//        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:5)
//        
//        sprite.runAction(SKAction.repeatActionForever(action))
        
        
        //defense.parent = self;
        
        // Store reference to self in userData
        sprite.userData = NSMutableDictionary()
        sprite.userData!.setValue(self,forKey: "object")
        
        
    }
    
    // Triggers attack strategy Attack function
    func TriggerAttack() {
        attack.parent = self
        attack.Attack()
    }
    
    // Triggers defense strategy Defend function
    func TriggerDefend() {
        defense.Defend()
    }
    
}