//
//  EnemyBase.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class EnemyBase: Entity{
    //Some variables for health and speed and whatnot
    var health = 20
    var sprite: SKSpriteNode
    var range: CGFloat = 0
    var attack: EnemyAttackStrat
    var moveStrat : EnemyMoveStrat
    var scene: SKScene
    var moveDelay : CGFloat
    
    //initlizer.
    init(_attack : EnemyAttackStrat, _scene: SKScene, _moveStrat :EnemyMoveStrat, _sprite : SKSpriteNode, _range: CGFloat, _moveDelay:CGFloat)
    {

        sprite = _sprite
        range = _range
        scene = _scene
        attack = _attack
        moveStrat = _moveStrat
        moveDelay = _moveDelay
        
        sprite.xScale = 0.25
        sprite.yScale = 0.25
        sprite.size = CGSizeMake(30, 30)
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)

        let actualY = random(min: 10.0, max: scene.size.height)

        sprite.position = CGPoint(x: GameScene.scene!.size.width, y:actualY)
        sprite.physicsBody?.categoryBitMask = CategoryMask.Enemy
        sprite.physicsBody?.contactTestBitMask = ContactMask.Enemy
        sprite.physicsBody?.collisionBitMask = CollisionMask.Enemy
        sprite.physicsBody?.collisionBitMask = BodyType.Enemy.rawValue
        sprite.physicsBody?.mass = 1
        sprite.physicsBody?.friction = 30.0
        sprite.physicsBody?.restitution = 0.0
        sprite.physicsBody?.linearDamping = 0.0
        sprite.physicsBody?.angularDamping = 0.0
        
        sprite.zPosition = ZPosition.enemy
               
        //Orient Enemy towards enemy
        //let action = SKAction.rotateByAngle(CGFloat(M_PI/2), duration:0.225)
        //sprite.runAction(action)

        //Set strategies
        moveStrat.Move(self)
        
        //Check to attack every two seconds
        /*if let _ = moveStrat as? ConcreteMoveStrat1{
            scene.runAction(SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.runBlock(moveMore),
                    SKAction.waitForDuration(2.0)
                    ])
                ))

        }
        else{
            moveStrat.Move(sprite)
        }*/
    }

    func setMoveStrategy(sentStrat: EnemyMoveStrat)
    {
        //let string = moveStrat.getMoveStrat()
        self.moveStrat = sentStrat
    }

    func moveMore(){
        moveStrat.Move(self)
    }
    // Triggers attack strategy Attack function
    func TriggerAttack() {
        

        for t in GameScene.towers{
            if(GameScene.getDistance(self.sprite.position, to: t.sprite.position) <= self.range){
                attack.parent = self
                attack.Attack()
            }
        }
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
    func getMoveStrat() -> EnemyMoveStrat
    {
        return moveStrat
    }
}