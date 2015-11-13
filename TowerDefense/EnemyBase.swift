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
    var totalAngle : CGFloat = 0
    
    //initlizer.
    init(_attack : EnemyAttackStrat, _scene: SKScene, _moveStrat :EnemyMoveStrat, _sprite : SKSpriteNode, _range: CGFloat)
    {

        sprite = _sprite
        range = _range
        scene = _scene

        sprite.xScale = 0.25
        sprite.yScale = 0.25
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.size = CGSizeMake(30, 30)
        sprite.physicsBody?.dynamic = false
        sprite.physicsBody?.categoryBitMask = CategoryMask.Enemy
        sprite.physicsBody?.contactTestBitMask = ContactMask.Enemy
        sprite.physicsBody?.collisionBitMask = CollisionMask.Enemy
        sprite.physicsBody?.collisionBitMask = BodyType.Enemy.rawValue
        sprite.zPosition = ZPosition.enemy
        
        //Orient Enemy towards left
        let action = SKAction.rotateByAngle(CGFloat(M_PI/2), duration:0.225)
        sprite.runAction(action)

        //Set strategies
        attack = _attack
        moveStrat = _moveStrat
        moveStrat.Move(sprite, scene: scene)
        
        //Check to attack every two seconds
        /*scene.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(TriggerAttack),
                SKAction.waitForDuration(1.5)
                ])
            ))*/
    }

    func setMoveStrategy()
    {
        //let string = moveStrat.getMoveStrat()
        moveStrat.Move(sprite, scene: scene)
    }

    // Triggers attack strategy Attack function
    func TriggerAttack() {
        
        attack.parent = self
        attack.Attack()
        /*for t in GameScene.towers{
            if(GameScene.getDistance(self.sprite.position, to: t.sprite.position) <= self.range){
                attack.Attack(self)
            }
        }*/
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