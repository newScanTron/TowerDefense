//
//  EnemyBullet.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/5/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyBullet {
    
    var sprite : SKSpriteNode
    var speed : Float
    var damage : Int
    var enemy : EnemyBase
    
    init (start : CGPoint, _target : CGPoint, _damage: Int, _speed : Float, inout _enemy : EnemyBase ) {
        
        sprite = SKSpriteNode(imageNamed: "bullet")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = start
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = CategoryMask.Tower
        sprite.physicsBody?.collisionBitMask = CollisionMask.Tower
        sprite.physicsBody?.contactTestBitMask = ContactMask.Tower
        sprite.physicsBody?.dynamic = true
        
        speed = _speed
        let action = SKAction.moveTo(_target, duration: 1) // TODO: Calculate duration to be distance/velocity
        sprite.runAction(SKAction.repeatActionForever(action))
        
        damage = _damage
        enemy = _enemy
        
        
    }
    
}