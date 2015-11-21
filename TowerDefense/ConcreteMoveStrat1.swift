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
    
    var lastMove : CGFloat = 2
 
    //Continuously call the execute method passing the strategy
    // and sprite to be moved
    override func Move(nodeToMove : EnemyBase){

        if (GameScene.gameTime > lastMove + moveDelay) {
            
            lastMove = GameScene.gameTime
            execute(nodeToMove)
        }
    }
    
    //Handles what strategy to use depending on the sprite position
    func execute(nodeToMove : EnemyBase){
        if (nodeToMove.sprite.position.y <= 10){
            nodeToMove.setMoveStrategy(stateYLow())
        }
        else if(nodeToMove.sprite.position.y >= 758){
            nodeToMove.setMoveStrategy(stateYHigh())
        }
        else if (nodeToMove.sprite.position.x < 200){
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-3), getImpulseY()))
        }
        else {
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX(), getImpulseY()))
        }
    }
}

//Handles enemy wander - when the y coordinate is approaching zero
class stateYLow : EnemyMoveStrat{
 
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase){
        if (GameScene.gameTime > lastMove + moveDelay) {
            
            lastMove = GameScene.gameTime

            nodeToMove.sprite.physicsBody?.friction = 200.0
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-1), (getImpulseYPos()*(3))))
            
            if(nodeToMove.sprite.position.y > 10){
                nodeToMove.sprite.physicsBody?.friction = 0.0
                nodeToMove.setMoveStrategy(ConcreteMoveStrat1())
            }
        }
    }
    
}

//Handles enemy wander in the other direction, top of screen
class stateYHigh : EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase){
        
        if GameScene.gameTime > lastMove + moveDelay{
            
            lastMove = GameScene.gameTime
            
            nodeToMove.sprite.physicsBody?.friction = 200.0
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-1), (getImpulseYNeg()*(3))))
            if (nodeToMove.sprite.position.y < 758){
                nodeToMove.sprite.physicsBody?.friction = 0.0
                nodeToMove.setMoveStrategy(ConcreteMoveStrat1())
            }
        }
    }
}