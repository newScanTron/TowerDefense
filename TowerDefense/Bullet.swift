//
//  Bullet.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/1/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet {
    
    var sprite : SKSpriteNode
    var speed : Float
    var damage : Int
    var tower : TowerBase
    
    init (start : CGPoint, _target : CGPoint, _damage: Int, _speed : Float, inout _tower : TowerBase ) {
        
        sprite = SKSpriteNode(imageNamed: "Bullet")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = start
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.dynamic = true
        
        
        speed = _speed
        let action = SKAction.moveTo(_target, duration: 1) // TODO: Calculate duration to be distance/velocity
        sprite.runAction(SKAction.repeatActionForever(action))
        
        damage = _damage
        tower = _tower
        
        
    }
}
