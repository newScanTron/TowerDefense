//
//  TowerAttackPulse.swift
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
    var circle : SKShapeNode?
    
    
    override init () {}
    
    override func Attack() {
        
        
        // If time since last pulse has passed
        if (!pulsing && GameScene.gameTime > lastFire + fireDelay) {
            // Start new pulse
            lastFire = GameScene.gameTime
            pulsing = true
            currentRadius = 0
            print("PULSE START")
                
        }
        

        
        if (pulsing) {
            if (currentRadius > (range)) {
                pulsing = false
                circle?.removeFromParent()
                print("PULSE END")
            }
            else {
                print("PULSING")
                
                currentRadius += speed
                let ratio : CGFloat = (1-(currentRadius/(range)))
                currentDamage = ratio * damage
                //print("currentDamage = (1-(" + String(currentRadius)  + "/(" + String(range) + "))) * " + String(damage) + " = " + String(currentDamage))
                
                for e in GameScene.getEnemiesInRange(parent!.sprite.position,range: currentRadius) {
                    
                    
                    //var out : String = "PULSE: " + String(e.health) + " - " + String(currentDamage)
                    e.health -= currentDamage
                    //out = out + " = " + String(e.health)
                    //print(out)
                }
                
                circle?.removeFromParent()
                circle = SKShapeNode(circleOfRadius: currentRadius)
               // ball = SKShapeNode.shapeNodeWithCircleOfRadius(radius: currentRadius)
                
                circle?.position = parent!.sprite.position
                circle?.lineWidth = 1.0;
                circle?.fillColor = SKColor(red: 0, green: 0, blue: 1, alpha: 1 * ratio)
                circle?.strokeColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1 * ratio*2)
                circle?.glowWidth = 0.5;
                circle?.zPosition = ZPosition.tower-1
                circle?.blendMode = SKBlendMode.Screen
                GameScene.scene?.addChild(circle!)
                

            }
        }
        
        
        
    }
    
}