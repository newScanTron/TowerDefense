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
    
    //Instance variable
    var range: CGFloat = 0
    var attack: EnemyAttackStrat
    var moveStrat : EnemyMoveStrat
    var isImmune : Bool = false
    var reward : Int
    var name : String = "George"
    var color = SKColor.greenColor()

    var indicator : SKSpriteNode
    
    var moveDelay : CGFloat
    
    //Initializer that sets all instance variables from the factory
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

        // Store reference to self in userData
        sprite.userData = NSMutableDictionary()
        sprite.userData!.setValue(self,forKey: "object")

//        healthLabel = SKLabelNode(fontNamed:"Verdana")
//        healthLabel.position = sprite.position
//        healthLabel.position.y -= 10
//        healthLabel.zPosition = 7
        //GameScene.scene!.addChild(healthLabel)

    }

    //Sets the move strategy
    func setMoveStrategy(sentStrat: EnemyMoveStrat)
    {
       moveStrat = sentStrat
    }

    //Sets attack strategy
    func setAttackStrategy(sentAttack: EnemyAttackStrat){
        self.attack = sentAttack
    }
    
    //Moves the sprite depending on the movement strategy set
    func moveMore(){
        
        //Some code to track the sprites
        let size = GameScene.scene!.size

        if (sprite.position.x < size.width && sprite.position.x > 0 && sprite.position.y < size.height && sprite.position.y > 0) {
                indicator.removeFromParent()
        }
        else {
            indicator.position.x = Clamp(sprite.position.x,min: 10,max: size.width-10)
            indicator.position.y = Clamp(sprite.position.y,min: 10,max: size.height-10)
            if (indicator.parent == nil) {
                GameScene.scene!.addChild(indicator)
            }
        }
        
        moveStrat.Move(self)
    }
    
    // Triggers attack strategy Attack function
    func TriggerAttack() {
        
        attack.parent = self
        attack.Attack()
    }
    
    //Check sprite position and health. If dead or too far off the screen the sprite is killed
    override func CheckIfDead() -> Bool {
        
        //offset to set how far off screen to allow sprite
        let offSet: CGFloat = 110
        if (health <= 0 || self.sprite.position.x < -offSet || self.sprite.position.x > GameScene.scene!.size.width + offSet || self.sprite.position.y > GameScene.scene!.size.height + offSet || self.sprite.position.y < -offSet ){
            attack.Die()
            indicator.removeFromParent()
            return true
        }
        return false
    }
    
    //Updates the sprites color based on health
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