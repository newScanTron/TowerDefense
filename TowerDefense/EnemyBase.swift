//
//  EnemyBase.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
class EnemyBase: Entity{
    //Some variables for health and speed and whatnot
    var health = 0
    var sprite: SKSpriteNode
    var attack: EnemyAttackStrat
    var moveStrat : EnemyMoveStrat
    var scene: SKScene
    
    //initlizer.
    init(_attack : EnemyAttackStrat, _scene: SKScene, _moveStrat :EnemyMoveStrat)
    {

        sprite = SKSpriteNode(imageNamed: "Spaceship")
        
        sprite.xScale = 0.25
        sprite.yScale = 0.25
        scene = _scene
  
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.dynamic = true
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Tower
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Tower

        attack = _attack
        moveStrat = _moveStrat
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    func randomVect(min min: CGFloat, max: CGFloat) -> CGVector{
        return CGVector(dx: random() * (max - min) + min, dy: 0)
    }
    func setMoveStrategy()
    {
        //let string = moveStrat.getMoveStrat()
        moveStrat.Move(sprite, scene: scene)
    }

    //move function conforming to the EnemyMoveStart
    func Move()
    {
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI/2), duration:0.125)
        
        sprite.runAction(SKAction.repeatAction(action, count: 1))
        
        //determine where to spawn the bison along the Y axis
        let actualY = random(min: sprite.size.height/2, max: scene.size.height - sprite.size.height/2)
        
        //Position the bison slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        sprite.position = CGPoint(x: scene.size.width + sprite.size.width/2, y:actualY)
        //determine speed of the monster
        sprite.physicsBody?.applyImpulse(randomVect(min: -50, max: -25))

        
    }
    // Triggers attack strategy Attack function
    func TriggerAttack(s: SKNode, t: SKNode) {
        attack.Attack(self, t: t, s: scene)
    }
    //attck function conforming to the EnemyAttackStart

    func getMoveStrat() -> EnemyMoveStrat
    {
        return moveStrat
    }
}