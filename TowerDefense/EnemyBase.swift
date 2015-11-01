//
//  EnemyBase.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
class EnemyBase: Entity, EnemyMoveStrat, EnemyAttackStrat
{
    //Some variables for health and speed and whatnot
    var health = 0
    var sprite: SKSpriteNode
    var scene: SKScene
    //initlizer
    init(sprite: SKSpriteNode, scene: SKScene)
    {
       self.sprite = sprite
        self.scene = scene
        sprite.xScale = 0.25
        sprite.yScale = 0.25
 
        
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)//create physics body for sprite
        sprite.physicsBody?.dynamic = true //sets sprite to dynamic (physics engine will not control movement)
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Enemy//sets category bitmask to monstercategory
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Tower //who to notify when contact listeners intersect, in this case projectiles
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Tower //dont bounce off of anything
        
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    //move function conforming to the EnemyMoveStart
    func Move()
    {
               //determine where to spawn the bison along the Y axis
        let actualY = random(min: sprite.size.height/2, max: scene.size.height - sprite.size.height/2)
        
        //Position the bison slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        sprite.position = CGPoint(x: scene.size.width + sprite.size.width/2, y:actualY)
        //determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        //Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: -sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        sprite.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    //attck function conforming to the EnemyAttackStart
    func Attack()
    {
        
    }
    
}