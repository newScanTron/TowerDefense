//
//  TowerBase.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/29/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerBase: Entity{
    var attack : TowerAttackStrat
    var defense : TowerDefenseStrat
    var attackSelection : Int = 0 // For the Tower Upgrade process, indicates what the currently selected attack and defense strategies are.
    var defenseSelection : Int = 0
    var value : Int = 0 // Value in gold of all attack strategies
    var attackSprite : SKSpriteNode // Sprite that changes based on attack strategy
    var color = SKColor.greenColor()
    
    init (location: CGPoint, _attack : TowerAttackStrat, _defense :TowerDefenseStrat )
    {
        
        attack = _attack;
        defense = _defense;
        attackSprite = SKSpriteNode(imageNamed: attack.imageName) // Sets attackSprite to sprite stored in new attack strategy
        
        super.init()
        
        sprite = SKSpriteNode(imageNamed: defense.imageName) // This is effectively the "defense" sprite
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        attackSprite.xScale = 0.5
        attackSprite.yScale = 0.5
        sprite.position = location
        attackSprite.position = location
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = CategoryMask.Tower
        sprite.physicsBody?.collisionBitMask = CollisionMask.Tower
        sprite.physicsBody?.contactTestBitMask = ContactMask.Tower
        
        //Testing
        sprite.physicsBody?.dynamic = true
        sprite.zPosition = ZPosition.tower
        attackSprite.zPosition = ZPosition.tower + 1
        sprite.name = "tower"
        
        // Store reference to self in userData. This is the only way to get a reference to this TowerBase when all we have is the SKSpriteNode
        sprite.userData = NSMutableDictionary()
        sprite.userData!.setValue(self,forKey: "object")

        
    }
    
    func setAttack(strat : TowerAttackStrat) {
        attack = strat
        attackSprite.texture  = SKTexture(imageNamed: strat.imageName)
    }
    
    func setDefense(strat : TowerDefenseStrat) {
        defense = strat
        sprite.texture  = SKTexture(imageNamed: strat.imageName)
    }
    
    // Triggers attack strategy Attack function
    func TriggerAttack() {
        attack.Attack(self)
    }
    
    override func CheckIfDead() -> Bool {
        if health <= 0 {
            attack.Die(self) // If I am dead, tell my strategies to do their death things
            defense.Die(self)
            return true
        }
        return false
    }
    
    // Triggers defense strategy Defend function
    func TriggerDefend() {
        defense.Defend(self)
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
        self.attackSprite.runAction(changeColorAction)
    }
}