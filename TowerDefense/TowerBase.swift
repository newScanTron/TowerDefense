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
    var sprite: SKSpriteNode
    init (location: CGPoint)
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
        
    }
}