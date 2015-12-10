//
//  ConcreteMoveStrat2.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class ConcreteMoveStrat2: EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
    var protect : EnemyBase? = nil
    let moveStrat = "concrete2"
    
    override func Move(nodeToMove: EnemyBase){
        
        let stop = SKAction.moveTo(parent!.sprite.position, duration: 0.0)
        
        if parent!.health < parent!.maxHealth * 0.2{
            parent!.sprite.runAction(stop)
        }
       


        
        protect = GameScene.getClosestEnemy(parent!.sprite.position, range: 500)
        
        
        
        /*if GameScene.gameTime > lastMove + nodeToMove.moveDelay {
            
            lastMove = GameScene.gameTime
            
            //determine where to spawn the bison along the Y axis
            let actualY = random(min: nodeToMove.sprite.size.height/2, max: GameScene.scene!.size.height - nodeToMove.sprite.size.height/2)
            
            //Position the bison slightly off-screen along the right edge,
            // and along a random position along the Y axis as calculated above
            nodeToMove.sprite.position = CGPoint(x: GameScene.scene!.size.width + nodeToMove.sprite.size.width/2, y: 200)
            //determine speed of the monster
            let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
            
            //Create the actions
            let moveLeft = SKAction.moveByX(-150, y:0, duration:2.0)
            let moveLeftQuick = SKAction.moveByX(-150, y:0, duration:0.5)
            let moveRight = SKAction.moveByX(150, y:0, duration: 0.5)
            let moveUp = SKAction.moveByX(0, y: 150, duration: 2.0)
            let moveUpQuick = SKAction.moveByX(0, y: 150, duration: 0.5)
            let moveDown = SKAction.moveByX(0, y: -150, duration: 2.0)
            let moveDownQuick = SKAction.moveByX(0, y: -150, duration: 0.5)
            let moveOff = SKAction.moveByX(-400, y:0, duration: 2.0)
            let moveDiagonal = SKAction.moveByX(-150, y: 150, duration: 1.5)
            
            let actionMove = SKAction.moveTo(CGPoint(x: -nodeToMove.sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
            let actionMoveDone = SKAction.removeFromParent()
            nodeToMove.sprite.runAction(SKAction.sequence([moveLeft, moveLeft, moveUp, moveLeft, moveDown,  moveUpQuick, moveLeftQuick, moveDownQuick, moveDiagonal, moveOff, actionMoveDone]))

        }*/
    }

    func getMoveStrat() -> String
    {
        return moveStrat
    }
}