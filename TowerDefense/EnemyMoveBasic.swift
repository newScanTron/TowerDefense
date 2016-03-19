//
//  EnemyMoveBasic.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveBasic: EnemyMoveStrat{
    
    //Instance variable
    var lastMove : CGFloat = 0
    let offSet : CGFloat = 150
    //Continuously call the execute method passing the strategy
    // and sprite to be moved
   
    override func Move(enemy : EnemyBase){

        //if (GameScene.gameTime > lastMove + enemy.moveDelay) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
            lastMove = appDelegate.gameScene!.gameTime
            
            //Handles what strategy to use depending on the sprite position

            if (enemy.sprite.position.y <= offSet){

                outOfBounds(enemy)
            }
            else if(enemy.sprite.position.y >= SideScrolScene.scene!.size.height - offSet){
                outOfBounds(enemy)

            }
            else if (enemy.sprite.position.x < offSet){
                outOfBounds(enemy)
            }
            else if (enemy.sprite.position.x > SideScrolScene.scene!.size.width - offSet) {
                outOfBounds(enemy)

            }
//            else if (nodeToMove.sprite.position.x > GameScene.scene!.size.width - 150) {
//                outOfBounds()
            //}
            else {
                enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYRand()))
            }
       // }
    }
}

class EnemyMoveBasicTowerDefense: EnemyMoveStrat{
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    //Instance variable
    var lastMove : CGFloat = 0
    let offSet : CGFloat = 150
    //Continuously call the execute method passing the strategy
    // and sprite to be moved
    override func Move(enemy : EnemyBase){
        
        //if (GameScene.gameTime > lastMove + enemy.moveDelay) {
        
        lastMove = appDelegate.gameScene!.gameTime
        
        //Handles what strategy to use depending on the sprite position
        
//        if (enemy.sprite.position.y <= offSet){
//            
//            outOfBounds(enemy)
//        }
//        else if(enemy.sprite.position.y >= SideScrolScene.scene!.size.height - offSet){
//            outOfBounds(enemy)
//            
//        }
//        else if (enemy.sprite.position.x < offSet){
//            outOfBounds(enemy)
//        }
//        else if (enemy.sprite.position.x > SideScrolScene.scene!.size.width - offSet) {
//            outOfBounds(enemy)
//            
//        }
//            //            else if (nodeToMove.sprite.position.x > GameScene.scene!.size.width - 150) {
//            //                outOfBounds()
//            //}
//        else {
            enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYRand()))
//        }
        // }
    }
}

//Handles enemy wander - when the y coordinate is approaching zero

class stateYLow : EnemyMoveStrat{
 
    var lastMove : CGFloat = 0
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    override func Move(nodeToMove : EnemyBase){
        if (appDelegate.gameScene!.gameTime > lastMove + nodeToMove.moveDelay) {
            
            lastMove = appDelegate.gameScene!.gameTime

            nodeToMove.sprite.physicsBody?.linearDamping = 0.50
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), (getImpulseYPos()*(3))))
            
            //Return to move strategy after enemy is back onto screen
            if(nodeToMove.sprite.position.y > 10){
                nodeToMove.sprite.physicsBody?.linearDamping = 0.0
                nodeToMove.setMoveStrategy(EnemyMoveBasic())
            }
        }
    }
}

//Handles enemy wander in the other direction, top of screen
class stateYHigh : EnemyMoveStrat{
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase){
        
        if appDelegate.gameScene!.gameTime > lastMove + nodeToMove.moveDelay{
            
            lastMove = appDelegate.gameScene!.gameTime
            
            nodeToMove.sprite.physicsBody?.linearDamping = 0.50
            nodeToMove.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), (getImpulseYNeg()*(3))))
            
            //Return to move strategy after enemy is back onto screen
            if (nodeToMove.sprite.position.y < 758){
                nodeToMove.sprite.physicsBody?.linearDamping = 0.0
                nodeToMove.setMoveStrategy(EnemyMoveBasic())
            }
        }
    }
}

