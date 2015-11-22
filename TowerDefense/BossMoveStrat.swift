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
    var spiral : SKAction! = nil
    
    override func Move(nodeToMove : EnemyBase){
        
       spiral = setSpiral(nodeToMove)
        
        if GameScene.gameTime > lastMove + nodeToMove.moveDelay{
            
            lastMove = GameScene.gameTime
            
            //determine where to spawn the bison along the Y axis
            //let actualY = random(min: nodeToMove.sprite.size.height/2, max: GameScene.scene!.size.height - nodeToMove.sprite.size.height/2)
            
            //nodeToMove.sprite.size = CGSize(width: 60, height: 60)
            //nodeToMove.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, 0.1))
            
            //determine speed of the monster
            let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
            
            //Create the actions
            let moveLeft = SKAction.moveByX(-150, y:0, duration: 2.0)
            let moveRight = SKAction.moveByX(150, y: 0, duration: 2.0)
            let moveUp = SKAction.moveByX(0, y: 150, duration: 3.0)
            let moveDown = SKAction.moveByX(0, y: -150, duration: 2.0)
            //let moveOff = SKAction.moveByX(-200, y:0, duration: 1.0)
            let moveDiagonal = SKAction.moveByX(-150, y: 150, duration: 1.5)
            
            //let actionMove = SKAction.moveTo(CGPoint(x: -nodeToMove.sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
            
            //let actionMoveDone = SKAction.removeFromParent()
            
            nodeToMove.sprite.runAction(SKAction.sequence([moveLeft, moveLeft, moveLeft, moveDiagonal, moveDiagonal.reversedAction(), moveUp, moveLeft, moveDown, moveLeft, moveUp, moveDiagonal.reversedAction()]))

        }
        
        //Changes all enemy move strategies to Swarm Strategy ... except da boss of course
        if nodeToMove.sprite.position.x < 1000{
            for e in GameScene.enemies{
                if e.sprite.name != "Boss"
                {
                    e.setMoveStrategy(EnemySwarmStrat())
                }
            }
        }
    }
    func setSpiral(nodeToSpiral : EnemyBase) -> SKAction{
        spiral = SKAction.spiral(GameScene.scene!.size.width / 8,
            endRadius: 0,
            angle: CGFloat(M_PI) * 2,
            centerPoint: CGPoint(x: nodeToSpiral.sprite.position.x, y: nodeToSpiral.sprite.position.y),
            duration: 3.0)
        
        return spiral
    }
}
class EnemySwarmStrat : EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase) {
        nodeToMove.moveDelay = 0
        //if GameScene.gameTime > lastMove + moveDelay{
        nodeToMove.sprite.physicsBody?.friction = 0
            //lastMove = GameScene.gameTime
        
        for e in GameScene.enemies{
            
            if e.sprite.name == "Boss"{
                let shifted = e.sprite.position.y - CGFloat(5)
                let shiftedPoint = CGPointMake(e.sprite.position.x, shifted)
                
                
                if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(250){
                    nodeToMove.sprite.physicsBody?.linearDamping = 0.75
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: shiftedPoint, speed: 2.0))
                }
                else if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(50) && GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) < 250 {
                    nodeToMove.sprite.physicsBody?.linearDamping = 0.5
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: shiftedPoint, speed: 5.0))
                }
                else {
                    nodeToMove.sprite.physicsBody?.linearDamping = 0
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: shiftedPoint, speed: 18.0))
                }
                
                /*if nodeToMove.sprite.speed > 30{
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: shiftedPoint, speed: -5.0))
                }
                else if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) < CGFloat(250){
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: shiftedPoint, speed: 10.0))
                }
                else {
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: shiftedPoint, speed: 10.0))
                }
                if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) < CGFloat(50){
                    
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: shiftedPoint, speed: -5.0))
                }*/
            }

        }
        
        

        
        //}

    }
    
    func getVector(from : CGPoint, to : CGPoint, speed : CGFloat) -> CGVector {
        let dis : CGFloat = GameScene.getDistance(from,to: to)
        return CGVectorMake((to.x - from.x)/dis * speed, (to.y - from.y)/dis * speed)
    }
}