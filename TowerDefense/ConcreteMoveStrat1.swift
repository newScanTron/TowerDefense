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
            
            lastMove = GameScene.gameTime
            
            //Handles what strategy to use depending on the sprite position
<<<<<<< HEAD

            if (enemy.sprite.position.y <= 150){
=======
            if (enemy.sprite.position.y <= offSet){
>>>>>>> origin/tobyDec10Branch
                outOfBounds(enemy)
            }
            else if(enemy.sprite.position.y >= GameScene.scene!.size.height - offSet){
                outOfBounds(enemy)

            }
            else if (enemy.sprite.position.x < offSet){
                outOfBounds(enemy)
            }
            else if (enemy.sprite.position.x > GameScene.scene!.size.width - offSet) {
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

//Handles enemy wander - when the y coordinate is approaching zero
//class stateYLow : EnemyMoveStrat{
// 
//    var lastMove : CGFloat = 0
//    
//    override func Move(enemy : EnemyBase){
//        if (GameScene.gameTime > lastMove + enemy.moveDelay) {
//            
//            lastMove = GameScene.gameTime
//
//            enemy.sprite.physicsBody?.linearDamping = 0.50
//            enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), (getImpulseYPos()*(3))))
//            
//            //Return to move strategy after enemy is back onto screen
//            if(enemy.sprite.position.y > 10){
//                enemy.sprite.physicsBody?.linearDamping = 0.0
//                enemy.setMoveStrategy(EnemyMoveBasic())
//            }
//        }
//    }
//}
//
////Handles enemy wander in the other direction, top of screen
//class stateYHigh : EnemyMoveStrat{
//    
//    var lastMove : CGFloat = 0
//    
//    override func Move(enemy : EnemyBase){
//        
//        if GameScene.gameTime > lastMove + enemy.moveDelay{
//            
//            lastMove = GameScene.gameTime
//            
//            enemy.sprite.physicsBody?.linearDamping = 0.50
//            enemy.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), (getImpulseYNeg()*(3))))
//            
//            //Return to move strategy after enemy is back onto screen
//            if (enemy.sprite.position.y < 758){
//                enemy.sprite.physicsBody?.linearDamping = 0.0
//                enemy.setMoveStrategy(EnemyMoveBasic())
//            }
//        }
//    }
//}