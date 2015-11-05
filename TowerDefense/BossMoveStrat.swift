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
        
    }
    func getMoveStrat() -> String
    {
        return moveStrat
    }

}