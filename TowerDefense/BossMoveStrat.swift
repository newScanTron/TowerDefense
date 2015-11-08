//
//  BossMoveStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/4/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

extension SKAction {
    
    static func spiral(startRadius: CGFloat, endRadius: CGFloat, angle
        totalAngle: CGFloat, centerPoint: CGPoint, duration: NSTimeInterval) -> SKAction {
            
            // The distance the node will travel away from/towards the
            // center point, per revolution.
            let radiusPerRevolution = (endRadius - startRadius) / totalAngle
            
            let action = SKAction.customActionWithDuration(duration) { node, time in
                // The current angle the node is at.
                let θ = totalAngle * time / CGFloat(duration)
                
                // The equation, r = a + bθ
                let radius = startRadius + radiusPerRevolution * θ
               
                node.position = pointOnCircle(θ, radius: radius, center: centerPoint)
            }
            
            return action
    }
}
func pointOnCircle(angle: CGFloat, radius: CGFloat, center: CGPoint) -> CGPoint {
    return CGPoint(x: center.x + radius * cos(angle),
        y: center.y + radius * sin(angle))
}

class BossMoveStrat: EnemyMoveStrat {
    let moveStrat = "concrete2"
    override func Move(sprite: SKSpriteNode, scene: SKScene){
        
        //determine where to spawn the bison along the Y axis
        let actualY = random(min: sprite.size.height/2, max: scene.size.height - sprite.size.height/2)
        
        //Position the bison slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        sprite.position = CGPoint(x: scene.size.width + sprite.size.width/2, y:actualY)
        //determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        //Create the actions
        let moveLeft = SKAction.moveByX(-150, y:0, duration:1.0)
        let moveUp = SKAction.moveByX(0, y: 150, duration: 1.0)
        let moveDown = SKAction.moveByX(0, y: -150, duration: 1.0)
        let moveOff = SKAction.moveByX(-200, y:0, duration: 1.0)
        let moveDiagonal = SKAction.moveByX(-150, y: 150, duration: 0.5)
        
        let actionMove = SKAction.moveTo(CGPoint(x: -sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        sprite.runAction(SKAction.sequence([moveLeft, moveDown, moveLeft, moveUp, moveLeft, moveDiagonal, moveLeft, moveDiagonal.reversedAction(), moveUp, moveLeft, moveDown, moveLeft, moveUp, moveDiagonal, moveOff, actionMoveDone]))
    }
    func getMoveStrat() -> String
    {
        return moveStrat
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
}