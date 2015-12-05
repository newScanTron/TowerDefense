
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
        circle?.removeFromParent()
        circle = nil
    }
    
    override func Die()  {
        circle?.removeFromParent()
        circle = nil
        for e in inRange {
            if (GameScene.getDistance(e.sprite.position,to: parent!.sprite.position) <= range) {
                e.moveStrat.slagged = false
                e.sprite.physicsBody?.linearDamping = 0
            }
        }
    }
    
    override func Defend() {
        
        if (circle == nil) {
            // Create new circle
            circle = SKShapeNode(circleOfRadius: range)
            circle?.position = parent!.sprite.position
            circle?.lineWidth = 0;
            circle?.fillColor = SKColor(red: 1, green: 0, blue: 1, alpha: 0.3)
            circle?.glowWidth = 0.5;
            circle?.zPosition = ZPosition.tower-1
            circle?.blendMode = SKBlendMode.Screen
            
            // Add circle to scene
            GameScene.scene?.addChild(circle!)
        }
        
        // Find enemies in radius, heal them
        
        for e in inRange {
            if (GameScene.getDistance(e.sprite.position,to: parent!.sprite.position) > range) {
                e.moveStrat.slagged = false
                e.sprite.physicsBody?.linearDamping = 0
            }
        }
        inRange = GameScene.getEnemiesInRange(parent!.sprite.position, range: range)
        
        for e in inRange {
            e.moveStrat.slagged = true
             e.sprite.physicsBody?.linearDamping = 1
            
        }
        
    }
    
}
