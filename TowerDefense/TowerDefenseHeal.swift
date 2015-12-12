//
//  TowerDefenseHeal.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/1/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerDefenseHeal : TowerDefenseStrat {
    
    var inRange : [TowerBase] = [TowerBase]()
    
    var circle : SKShapeNode?
    
    override init () {
        
        super.init()
        imageName = "healBase"
        self.setRangeLevel(0)
        self.setAmountLevel(0)
    }
    
    override func setRangeLevel(level : Int) {
        rangeLevel = level
        range = 75 + CGFloat(level) * 25
        circle?.removeFromParent()
        circle = nil
    }
    override func setAmountLevel(level : Int) {
        amountLevel = level
        amount = 0.02 + CGFloat(level) * 0.005
        circle?.removeFromParent()
        circle = nil
    }
    
    override func Die(tower : TowerBase)  {
        circle?.removeFromParent()
        circle = nil
    }
    
    override func copy() -> TowerDefenseHeal {
        let strat = TowerDefenseHeal()
        strat.setRangeLevel(rangeLevel)
        strat.setAmountLevel(amountLevel)
        return strat
    }
    
    override func Defend(tower : TowerBase) {
        
        if (circle == nil) {
            // Create new circle
            circle = SKShapeNode(circleOfRadius: range)
            circle?.position = tower.sprite.position
            circle?.lineWidth = 0;
            circle?.fillColor = SKColor(red: 1, green: 0, blue: 0, alpha: 0.3)
            circle?.glowWidth = 0.5;
            circle?.zPosition = ZPosition.tower-1
            circle?.blendMode = SKBlendMode.Screen
            
            // Add circle to scene
            GameScene.scene?.addChild(circle!)
        }
        
        // Find enemies in radius, heal them
        
        inRange = getTowersInRange(tower.sprite.position, range: range)
        
        for t in inRange {
            t.health += amount
            if (t.health > t.maxHealth) {
                t.health = t.maxHealth
            }
            
        }
        
    }
    
}
