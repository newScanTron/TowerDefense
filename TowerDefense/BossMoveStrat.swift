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
    
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase){
        
        if GameScene.gameTime > lastMove + moveDelay{
            
            lastMove = GameScene.gameTime
            
            //determine where to spawn the bison along the Y axis
            let actualY = random(min: nodeToMove.sprite.size.height/2, max: GameScene.scene!.size.height - nodeToMove.sprite.size.height/2)
            
            nodeToMove.sprite.size = CGSize(width: 80, height: 80)
            
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
                duration: 3.0)
            
            //TakeOverEnemies(nodeToMove)
            
            let actionMove = SKAction.moveTo(CGPoint(x: -nodeToMove.sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
            let actionMoveDone = SKAction.removeFromParent()
            nodeToMove.sprite.runAction(SKAction.sequence([moveLeft, moveLeft, moveLeft, spiral, moveRight, spiral, moveDiagonal.reversedAction(), moveUp, moveLeft, moveDown, moveLeft, moveUp, moveDiagonal, actionMoveDone]))

        }        
    }
    func TakeOverEnemies(bossNode : EnemyBase) {
        for e in GameScene.enemies{
            if e.sprite.name != "Boss"{
                e.setMoveStrategy(EnemySwarmStrat())
                e.moveStrat.Move(e)
            }
        }
    }
}
class EnemySwarmStrat : EnemyMoveStrat{
    
    override func Move(nodeToMove : EnemyBase) {
        for e in GameScene.enemies{
            if e.sprite.name == "Boss"{
                nodeToMove.sprite.physicsBody?.applyForce(getVector(e.sprite.position, to: e.sprite.position, speed: 100.0))
            }
        }
        
        func execute(){
            
        }
    }
    
    func getVector(from : CGPoint, to : CGPoint, speed : CGFloat) -> CGVector {
        let dis : CGFloat = GameScene.getDistance(from,to: to)
        return CGVectorMake((to.x - from.x)/dis * speed, (to.y - from.y)/dis * speed)
    }
}