//
//  TowerAttackLazer.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 11/29/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//


import Foundation
import SpriteKit

class TowerAttackPulse : TowerAttackStrat {
    
    var lastFire : CGFloat = 0
    
    var pulsing : Bool = false
    
    var currentRadius : CGFloat = 0
    var currentDamage : CGFloat = 0
    
    
    override init () {}
    
    override func Attack() {
        
        
        // If time since last pulse has passed
        if (GameScene.gameTime > lastFire + fireDelay) {
            // Start new pulse
            pulsing = true
            currentRadius = 0
                
        }
        

        
        if (pulsing) {
            if (currentRadius > (range)) {
                pulsing = false
            }
            else {
                currentRadius += speed
                currentDamage = (1-(currentRadius/(range))) * damage
                
                
                
                let ball : SKShapeNode = SKShapeNode(circleOfRadius: currentRadius)
               // ball = SKShapeNode.shapeNodeWithCircleOfRadius(radius: currentRadius)
                
                
                ball.lineWidth = 1.0;
                ball.fillColor = SKColor.blueColor()
                ball.strokeColor = SKColor.whiteColor()
                ball.glowWidth = 0.5;
                ball.zPosition = ZPosition.bullet
                

            }
        }
        
        
        
    }
    
}