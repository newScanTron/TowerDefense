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
    var isImmune : Bool = false
    var reward : Int
    var name : String = "George"
    var color = SKColor.greenColor()

    var indicator : SKSpriteNode
    
    var moveDelay : CGFloat
                let circle = SKShapeNode(circleOfRadius: 125.0)
    //initlizer.
    init(_attack : EnemyAttackStrat, _moveStrat :EnemyMoveStrat, _sprite : SKSpriteNode, _range: CGFloat, _moveDelay:CGFloat, _reward : Int, _name :String)
    {
    
        
        
        attack = _attack
        moveStrat = _moveStrat
        moveDelay = _moveDelay
        reward  = _reward
        name = _name
        
        indicator = SKSpriteNode(imageNamed: "indicator")
        indicator.xScale = 0.1
        indicator.yScale = 0.1
        indicator.zPosition = ZPosition.enemy + 1
        
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
        sprite.physicsBody?.mass = 1
        sprite.physicsBody?.restitution = 0.0
        sprite.physicsBody?.linearDamping = 0.0
        sprite.physicsBody?.angularDamping = 0.0
        sprite.physicsBody?.allowsRotation = false

        //moveStrat.Move(self)
        
//        healthLabel = SKLabelNode(fontNamed:"Verdana")
//        healthLabel.position = sprite.position
//        healthLabel.position.y -= 10
//        healthLabel.zPosition = 7
        //GameScene.scene!.addChild(healthLabel)

    }

    func setMoveStrategy(sentStrat: EnemyMoveStrat)
    {
       moveStrat = sentStrat
    }

    func setAttackStrategy(sentAttack: EnemyAttackStrat){
        self.attack = sentAttack
    }
    func moveMore(){
        
        let size = GameScene.scene!.size

        if (sprite.position.x < size.width && sprite.position.x > 0 && sprite.position.y < size.height && sprite.position.y > 0) {
                indicator.removeFromParent()
        }
        else {
            indicator.position.x = Clamp(sprite.position.x,min: 10,max: size.width-10)
            indicator.position.y = Clamp(sprite.position.y,min: 10,max: size.height-10)
            if (indicator.parent == nil) {
                print("indicated")
                GameScene.scene!.addChild(indicator)
            }
        }
        
        
        moveStrat.parent = self
        moveStrat.Move(self)
    }
    // Triggers attack strategy Attack function
    func TriggerAttack() {
        
//        healthLabel.text = String(health)
//        healthLabel.position = sprite.position
//        healthLabel.position.y -= 20
 
        attack.parent = self
        attack.Attack()
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
    override func CheckIfDead() -> Bool {
        if health <= 0 || self.sprite.position.x < -80 || self.sprite.position.x > GameScene.scene!.size.width + 80 || self.sprite.position.y > GameScene.scene!.size.height + 80 || self.sprite.position.y < -80{
            attack.Die()
            indicator.removeFromParent()
            return true
        }
        return false
    }
    func UpdateLabel(){
        
        if self.health >= (maxHealth * 0.99) {
            color = SKColor.whiteColor()
        }
        else if self.health >= (maxHealth * 0.8){
            color = SKColor.grayColor()
        }
        else if self.health >= (maxHealth * 0.50){
            color = SKColor.yellowColor()
        }
        else if self.health >= (maxHealth * 0.3) {
            color = SKColor.orangeColor()
        }
        else if self.health >= 0  {
            color = SKColor.redColor()
        }
        let changeColorAction = SKAction.colorizeWithColor(color, colorBlendFactor: 1.0, duration: 0.05)
        self.sprite.runAction(changeColorAction)
    }
}