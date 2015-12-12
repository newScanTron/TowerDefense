
//
//  TowerDefenseSlag.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/29/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerDefenseSlag : TowerDefenseStrat {
    
    var inRange : [EnemyBase] = [EnemyBase]()
    
    var circle : SKShapeNode?
    
    override init () {
        super.init()
        imageName = "slagBase"
        self.setAmountLevel(0)
        self.setRangeLevel(0)
    }
    
    override func setRangeLevel(level : Int) {
        rangeLevel = level
        range = 75 + CGFloat(level) * 25
        circle?.removeFromParent()
        circle = nil
    }
    override func setAmountLevel(level : Int) {
        amountLevel = level
        amount = 2 + CGFloat(level) * 0.5
    }
    
    override func Die(tower : TowerBase)  {
        circle?.removeFromParent()
        circle = nil
        for e in inRange {
            if (getDistance(e.sprite.position,to: tower.sprite.position) <= range) {
                e.moveStrat.slagged = false
                e.sprite.physicsBody?.linearDamping = 0
            }
        }
    }
    
    override func copy() -> TowerDefenseSlag {
        let strat = TowerDefenseSlag()
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
            circle?.fillColor = SKColor(red: 1, green: 0, blue: 1, alpha: 0.3)
            circle?.glowWidth = 0.5;
            circle?.zPosition = ZPosition.tower-1
            circle?.blendMode = SKBlendMode.Screen
            
            // Add circle to scene
            GameScene.scene?.addChild(circle!)
        }
        
        // Find enemies in radius, slow them down
        
        
        // First resets all of the previously slagged enemies to unslagged
        for e in inRange {
            if (getDistance(e.sprite.position,to: tower.sprite.position) > range) {
                e.moveStrat.slagged = false
                e.sprite.physicsBody?.linearDamping = 0
            }
        }
        inRange = getEnemiesInRange(tower.sprite.position, range: range)
        
        // Then sets new set of enemies to slagged
        for e in inRange {
            e.moveStrat.slagged = true
            e.sprite.physicsBody?.linearDamping = 1
            
        }
        
    }
    
}
