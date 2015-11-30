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

    var range: CGFloat = 0
    var attack: EnemyAttackStrat
    var moveStrat : EnemyMoveStrat
    
    var moveDelay : CGFloat
    
    //initlizer.
    init(_attack : EnemyAttackStrat, _moveStrat :EnemyMoveStrat, _sprite : SKSpriteNode, _range: CGFloat, _moveDelay:CGFloat)
    {

        attack = _attack
        moveStrat = _moveStrat
        moveDelay = _moveDelay
        
        super.init()
        sprite = _sprite
        range = _range

        sprite.xScale = 0.25
        sprite.yScale = 0.25

        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, 0.1))

        let actualY = random(min: 10.0, max: GameScene.scene!.size.height)

        sprite.position = CGPoint(x: GameScene.scene!.size.width, y:actualY)
        sprite.physicsBody?.dynamic = true
        sprite.physicsBody?.categoryBitMask = CategoryMask.Enemy
        sprite.physicsBody?.contactTestBitMask = ContactMask.Enemy
        sprite.physicsBody?.collisionBitMask = CollisionMask.Enemy
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Enemy.rawValue
        sprite.physicsBody?.mass = 1
        sprite.physicsBody?.restitution = 0.0
        sprite.physicsBody?.linearDamping = 0.0
        sprite.physicsBody?.angularDamping = 0.0
        sprite.physicsBody?.allowsRotation = false
        sprite.zPosition = ZPosition.enemy

        moveStrat.Move(self)
        
        healthLabel = SKLabelNode(fontNamed:"Verdana")
        healthLabel.position = sprite.position
        healthLabel.position.y -= 10
        healthLabel.zPosition = 7
        //GameScene.scene!.addChild(healthLabel)
        
        
        
    }

    func setMoveStrategy(sentStrat: EnemyMoveStrat)
    {
        //let string = moveStrat.getMoveStrat()
        self.moveStrat = sentStrat

    }

    func setAttackStrategy(sentAttack: EnemyAttackStrat){
        self.attack = sentAttack
    }
    func moveMore(){
        moveStrat.parent = self
        moveStrat.Move(self)
    }
    // Triggers attack strategy Attack function
    func TriggerAttack() {
        
        healthLabel.text = String(health)
        healthLabel.position = sprite.position
        healthLabel.position.y -= 20
        
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