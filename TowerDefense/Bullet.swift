//
//  Bullet.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/1/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet : Item {
    
    var sprite : SKSpriteNode
    var target : SKSpriteNode
    var shooter : Entity  // Entity that fired this bullet
    var speed : CGFloat = 0
    var damage : CGFloat = 0
    var explosion : Explosion?
    var startTime : CGFloat = 0
    var lifeTime : CGFloat = 10
    var homingOn : Bool = false
    var homingForce : CGFloat = 0
    
    
    init (_shooter : Entity, _target : SKSpriteNode, _speed : CGFloat, _damage : CGFloat, size : CGFloat, shotByEnemy : Bool) {
        shooter = _shooter
        target = _target
        speed = _speed
        damage = _damage
        sprite = SKSpriteNode(imageNamed: "bullet")
        sprite.size = CGSizeMake(size,size)
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        if (shotByEnemy) {
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
        
        super.init()
        
        // Store reference to self in userData
        sprite.userData = NSMutableDictionary()
        sprite.userData!.setValue(self,forKey: "object")
        
        // Set up initial location and size of projectile
        sprite.position = shooter.sprite.position
        
        activate()
        
    }
    
    func setLifeTime(_lifeTime : CGFloat) {
        lifeTime = _lifeTime
    }
    
    func setExplosion(_explosion : Explosion) {
        explosion = _explosion
    }
    
    func setHoming(_homingOn : Bool, _homingForce : CGFloat) {
        homingOn = _homingOn
        homingForce = _homingForce
    }
    
    
    
    func activate() {
        
        // Set start time so we can calculate when lifeTime has expired
        startTime = GameScene.gameTime
        
        // Add to scene
        GameScene.scene!.addChild(sprite)
        GameScene.items.append(self)
        
        sprite.physicsBody?.velocity = Bullet.getVector(sprite.position, to: target.position, speed: speed)
        
    }
    
    
    
    override func update() {
        if (GameScene.gameTime > startTime + lifeTime) {
            destroyThis = true
        }
        else if (homingOn){
            //print("homing")
            if (target.parent != nil) {
                sprite.physicsBody?.velocity = Bullet.getVector(sprite.position, to: target.position, speed: speed)
            }
        }
    }
    
    override func destroy() {
        explosion?.trigger(sprite.position)
        sprite.removeFromParent()
    }
    
    
    
    class func getVector(from : CGPoint, to : CGPoint, speed : CGFloat) -> CGVector {
        let dis : CGFloat = GameScene.getDistance(from,to: to) // We divide the vector by this (the length of the vector) to ensure it is normalized
        return CGVectorMake((to.x - from.x)/dis * speed, (to.y - from.y)/dis * speed)
    }
    
}