//
//  RangedAttack.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class RangedAttack: EnemyAttackStrat{
    
    var lastFire : Float = 0
    
    
    override init(){}
    
    /*override func Attack() {
        
        if (GameScene.gameTime > lastFire + fireDelay) {
            lastFire = GameScene.gameTime
            if (parent != nil) {
                target = GameScene.getClosestTower(parent!.sprite.position)
                EnemyBullet(
                    start: parent!.sprite.position,
                    _target: target!.sprite.position,
                    _damage: damage,
                    _speed: speed,
                    _enemy: &parent!
                )
            }
        }
    }*/
    
    override func Attack(enemy: EnemyBase, scene: SKScene, target: CGPoint){
        
        enum BodyType: UInt32 {
            case Bullet = 3
        }
        
        let attackLocation = target
        var totalAngle : CGFloat = 0
        var angle : CGFloat
        // Set up initial location of projectile
        let projectile = SKSpriteNode(imageNamed: "bullet")
        projectile.size = CGSizeMake(27, 27)
        projectile.position = enemy.sprite.position
        
        //Set up collisions
        projectile.physicsBody = SKPhysicsBody(rectangleOfSize: projectile.size)
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.Bullet
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        projectile.physicsBody?.dynamic = false
        projectile.physicsBody?.collisionBitMask = BodyType.Bullet.rawValue
        projectile.zPosition = ZPosition.bullet
        
        //Point to target
        // Calculate the angle using the relative positions of the enemy sprite and closest tower.
        angle = atan2(enemy.sprite.position.y - attackLocation.y, enemy.sprite.position.x - attackLocation.x)
        angle -= totalAngle
        totalAngle += angle
        
        let action = SKAction.rotateByAngle(angle, duration:0.005)
        projectile.runAction(SKAction.repeatAction(action, count: 1))
        
        // Determine offset of location to projectile
        let offset = attackLocation - projectile.position
        scene.addChild(projectile)
        
        // Get the direction of where to shoot
        let direction = offset.normalized()
        
        // Make it shoot far enough to be guaranteed off screen
        let shootAmount = direction * 1000
        
        // Add the shoot amount to the current position
        let realDest = shootAmount + projectile.position
        
        // Create actions
        let actionMove = SKAction.moveTo(realDest, duration: 1.5)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
}