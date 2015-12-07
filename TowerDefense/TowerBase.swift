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
    var attackSelection : Int = 0
    var defenseSelection : Int = 0
    var value : Int = 0
    var attackSprite : SKSpriteNode

    init (location: CGPoint, _attack : TowerAttackStrat, _defense :TowerDefenseStrat )
    {
        
        attack = _attack;
        defense = _defense;
        attackSprite = SKSpriteNode(imageNamed: attack.imageName)
        
        super.init()
        
        sprite = SKSpriteNode(imageNamed: defense.imageName)
        
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
        sprite.physicsBody?.dynamic = false
        sprite.zPosition = ZPosition.tower
        attackSprite.zPosition = ZPosition.tower + 1
        sprite.name = "tower"
        
        // Store reference to self in userData
        sprite.userData = NSMutableDictionary()
        sprite.userData!.setValue(self,forKey: "object")
        
        // For some reason, adding these sprites to the scene at init was causing a crash before the login menu even loads. No idea. This fixed it.
        if (GameScene.scene != nil) {
            GameScene.scene!.addChild(sprite)
            GameScene.scene!.addChild(attackSprite)
        }
        
        
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
            attack.Die(self)
            defense.Die(self)
            attackSprite.removeFromParent()
            return true
        }
        return false
    }
    
    // Triggers defense strategy Defend function
    func TriggerDefend() {
        defense.Defend(self)
    }
    
}