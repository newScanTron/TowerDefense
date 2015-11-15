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
    override func Move(sprite: SKSpriteNode){
        
        //determine where to spawn the bison along the Y axis
        let actualY = random(min: sprite.size.height/2, max: GameScene.scene!.size.height - sprite.size.height/2)
        sprite.size = CGSize(width: 80, height: 80)
        //Position the bison slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        sprite.position = CGPoint(x: GameScene.scene!.size.width + sprite.size.width/2, y:actualY)
        //determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        //Create the actions
        let moveLeft = SKAction.moveByX(-150, y:0, duration:3.0)
        let moveRight = SKAction.moveByX(150, y: 0, duration: 2.0)
        let moveUp = SKAction.moveByX(0, y: 150, duration: 3.0)
        let moveDown = SKAction.moveByX(0, y: -150, duration: 2.0)
        let moveOff = SKAction.moveByX(-200, y:0, duration: 1.0)
        let moveDiagonal = SKAction.moveByX(-150, y: 150, duration: 1.5)
        
        let spiral = SKAction.spiral(GameScene.scene!.size.width / 8,
            endRadius: 0,
            angle: CGFloat(M_PI) * 2,
            centerPoint: CGPoint(x: 400, y: actualY),
            duration: 5.0)
        
        let actionMove = SKAction.moveTo(CGPoint(x: -sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        sprite.runAction(SKAction.sequence([moveLeft, moveLeft, moveLeft, spiral, moveRight, spiral, moveDiagonal.reversedAction(), moveUp, moveLeft, moveDown, moveLeft, moveUp, moveDiagonal, actionMoveDone]))
        //sprite.runAction(spiral)
    }
    func getMoveStrat() -> String
    {
        return moveStrat
    }

}