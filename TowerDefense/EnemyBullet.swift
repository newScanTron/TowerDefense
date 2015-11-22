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
    var damage : Int
    var entity : Entity
    
    init (_start : CGPoint, _target : CGPoint, _speed : CGFloat, _damage: Int, inout _entity : Entity, _shotByEnemy : Bool) {
        
        // Set up initial location of projectile
        sprite = SKSpriteNode(imageNamed: "bullet")
        sprite.size = CGSizeMake(27, 27)
        sprite.position = _start
        
        //Set up collisions
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)

        sprite.physicsBody?.categoryBitMask = CategoryMask.Bullet
        sprite.physicsBody?.collisionBitMask = CollisionMask.Bullet
        sprite.physicsBody?.contactTestBitMask = ContactMask.EnemyBullet
        if (_shotByEnemy) {
            sprite.physicsBody?.contactTestBitMask = ContactMask.TowerBullet
        }
        else {
            sprite.physicsBody?.contactTestBitMask = ContactMask.EnemyBullet
        }
        sprite.physicsBody?.mass = 1
        sprite.physicsBody?.friction = 0.0
        sprite.physicsBody?.restitution = 0.0
        sprite.physicsBody?.linearDamping = 0.0
        sprite.physicsBody?.angularDamping = 0.0

        sprite.physicsBody?.dynamic = true
        sprite.zPosition = ZPosition.bullet
        
        
        GameScene.scene!.addChild(sprite)
        
        let vec : CGVector = EnemyBullet.getVector(_start, to: _target, speed: _speed * 100)
        
        print("x: ",vec.dx ," y: " ,vec.dy)
        
        sprite.physicsBody?.applyImpulse(EnemyBullet.getVector(_start, to: _target, speed: _speed * 100))
        
        damage = _damage
        entity = _entity
        
        
        
    }
    
    class func getVector(from : CGPoint, to : CGPoint, speed : CGFloat) -> CGVector {
        let dis : CGFloat = GameScene.getDistance(from,to: to)
        return CGVectorMake((to.x - from.x)/dis * speed, (to.y - from.y)/dis * speed)
    }
    
}