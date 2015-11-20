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
    
    //Empty init
    override init() {}

    //Continuously call the execute method passing the strategy
    // and sprite to be moved
    override func Move(nodeToMove :EnemyBase){
        let passedSprite = nodeToMove.sprite
        let passedStrat = nodeToMove.moveStrat
        //print(sprite.position.x, sprite.position.y)
        GameScene.scene!.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock({self.execute(passedStrat, passedSprite: passedSprite)}),
                SKAction.waitForDuration(2.0)
                ])
            ))
    }
    
    //Handles what strategy to use depending on the sprite position
    func execute(passedStrat : EnemyMoveStrat, passedSprite :SKSpriteNode){
        if (passedSprite.position.y <= 10){
            passedStrat.setState(stateYLow())
        }
        else if(passedSprite.position.y >= 758){
            passedStrat.setState(stateYHigh())
        }
        else if (passedSprite.position.x < 200){
            passedSprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-3), getImpulseY()))
        }
        else {
            passedSprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX(), getImpulseY()))
        }
    }
}
//Handles enemy wander - when the y coordinate is approaching zero
class stateYLow : EnemyMoveStrat{
    override func Move(nodeToMove : EnemyBase){
        nodeToMove.sprite.physicsBody?.friction = 200.0
        nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-1), (getImpulseYPos()*(3))))
        if(nodeToMove.sprite.position.y > 10){
            nodeToMove.sprite.physicsBody?.friction = 0.0
            nodeToMove.setMoveStrategy(ConcreteMoveStrat1())
        }
    }
    
}
//Handles enemy wander in the other direction, top of screen
class stateYHigh : EnemyMoveStrat{
    override func Move(nodeToMove : EnemyBase){
        nodeToMove.sprite.physicsBody?.friction = 200.0
        nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-1), (getImpulseYNeg()*(3))))
        if (nodeToMove.sprite.position.y < 758){
            nodeToMove.sprite.physicsBody?.friction = 0.0
            nodeToMove.setMoveStrategy(ConcreteMoveStrat1())
        }
    }
}