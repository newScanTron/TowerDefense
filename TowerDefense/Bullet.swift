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
    var damage : CGFloat // Damage that will be dealt
    var entity : Entity // Entity that fired this bullet
    
    init (_start : CGPoint, _target : CGPoint, _speed : CGFloat, _damage: CGFloat, inout _entity : Entity, _shotByEnemy : Bool) {
        
        damage = _damage
        entity = _entity
        
        // Set up initial location of projectile
        sprite = SKSpriteNode(imageNamed: "bullet")
        sprite.size = CGSizeMake(27, 27)
        sprite.position = _start
        
        //Set up collisions
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        if (_shotByEnemy) {
            sprite.physicsBody?.categoryBitMask = CategoryMask.EnemyBullet
            sprite.physicsBody?.collisionBitMask = CollisionMask.EnemyBullet
            sprite.physicsBody?.contactTestBitMask = ContactMask.EnemyBullet
        }
        else {
            sprite.physicsBody?.categoryBitMask = CategoryMask.TowerBullet
            sprite.physicsBody?.collisionBitMask = CollisionMask.TowerBullet
            sprite.physicsBody?.contactTestBitMask = ContactMask.TowerBullet
        }
        
        // Set up physics traits
        sprite.physicsBody?.mass = 1
        sprite.physicsBody?.friction = 0.0
        sprite.physicsBody?.restitution = 0.0
        sprite.physicsBody?.linearDamping = 0.0
        sprite.physicsBody?.angularDamping = 0.0
        sprite.physicsBody?.dynamic = true
        sprite.zPosition = ZPosition.bullet
        
        // Add to scene
        GameScene.scene!.addChild(sprite)
        

        // Store reference to self in userData
        sprite.userData = NSMutableDictionary()
        sprite.userData!.setValue(self,forKey: "object")

        
        //print(sprite.userData!["object"] as! Bullet)

        // Apply impulse vector
        sprite.physicsBody?.applyImpulse(Bullet.getVector(_start, to: _target, speed: _speed))
        
    }
    
    func sendDamage(inout recipient : Entity) {
        
        recipient.health = recipient.health - damage // Subtracts damage from other entity's health
        
        if (recipient.health <= 0) {
            recipient.sprite.removeFromParent() // If health is <= 0, destroys entity
        }
        
        entity.kills += 1; // Adds 1 to the parent entitys kill count
        
    }
    
    class func getVector(from : CGPoint, to : CGPoint, speed : CGFloat) -> CGVector {
        let dis : CGFloat = GameScene.getDistance(from,to: to) // We divide the vector by this (the length of the vector) to ensure it is normalized
        return CGVectorMake((to.x - from.x)/dis * speed, (to.y - from.y)/dis * speed)
    }
    
}