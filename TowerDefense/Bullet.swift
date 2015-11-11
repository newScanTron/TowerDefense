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
    var damage : Int
    var entity : Entity
    
    init (start : CGPoint, _vector : CGVector, _damage: Int, inout _entity : Entity ) {
        
        sprite = SKSpriteNode(imageNamed: "bullet")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = start
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.dynamic = true
        
        sprite.physicsBody?.applyImpulse(_vector);
        
        damage = _damage
        entity = _entity
        
        GameScene.scene!.addChild(sprite)
        
        
    }
    
}
