//
//  ConcreteMoveStrat1.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class ConcreteMoveStrat1: EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
 
    //Continuously call the execute method passing the strategy
    // and sprite to be moved
    override func Move(nodeToMove : EnemyBase){

        if (GameScene.gameTime > lastMove + nodeToMove.moveDelay) {
            
            lastMove = GameScene.gameTime
            //Handles what strategy to use depending on the sprite position
            if (nodeToMove.sprite.position.y <= 10){
                outOfBounds()
            }
            else if(nodeToMove.sprite.position.y >= 758){
                outOfBounds()
            }
            else if (nodeToMove.sprite.position.x < 200){
              outOfBounds()
            }
            else {
                nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXNeg(), getImpulseYRand()))
            }
        }
    }
}

//Handles enemy wander - when the y coordinate is approaching zero
class stateYLow : EnemyMoveStrat{
 
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase){
        if (GameScene.gameTime > lastMove + nodeToMove.moveDelay) {
            
            lastMove = GameScene.gameTime

            nodeToMove.sprite.physicsBody?.linearDamping = 0.50
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), (getImpulseYPos()*(3))))
            
            //Return to move strategy after enemy is back onto screen
            if(nodeToMove.sprite.position.y > 10){
                nodeToMove.sprite.physicsBody?.linearDamping = 0.0
                nodeToMove.setMoveStrategy(ConcreteMoveStrat1())
            }
        }
    }
}

//Handles enemy wander in the other direction, top of screen
class stateYHigh : EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase){
        
        if GameScene.gameTime > lastMove + nodeToMove.moveDelay{
            
            lastMove = GameScene.gameTime
            
            nodeToMove.sprite.physicsBody?.linearDamping = 0.50
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), (getImpulseYNeg()*(3))))
            
            //Return to move strategy after enemy is back onto screen
            if (nodeToMove.sprite.position.y < 758){
                nodeToMove.sprite.physicsBody?.linearDamping = 0.0
                nodeToMove.setMoveStrategy(ConcreteMoveStrat1())
            }
        }
    }
}