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
    
    var totalImpulseX : CGFloat = 0
    var totalImpulseY : CGFloat = 0
    
    let howToMove = StateContext()
    
    override init() {}

    override func Move(sprite: SKSpriteNode){
        
        
        
        var randForVecX = getImpulseX()
        var randForVecY = getImpulseY()
        
        totalImpulseX += randForVecX
        totalImpulseY += randForVecY
        //print(sprite.position.x, sprite.position.y)
        
        
        howToMove.setImpulse(sprite)
        
        /*if (sprite.position.x < 1024){

            
            if (sprite.position.y <= 0){
                
                
                //sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX(), (getImpulseY()*(2))))
                //totalImpulseY -= (totalImpulseY - 20)
            }
            else if(sprite.position.y >= 768){
                sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX(), -(getImpulseY()*(2))))
                //totalImpulseY -= (totalImpulseY - 20)
        
            }
            else {
                sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX(), getImpulseY()))
        
            }
        }
        else {
            if (sprite.position.y <= 0){
                sprite.physicsBody?.applyImpulse(CGVectorMake(randForVecX, (totalImpulseY*(2))))

                totalImpulseY -= (totalImpulseY - 20)
            }
            else if(sprite.position.y >= 768){
                sprite.physicsBody?.applyImpulse(CGVectorMake(randForVecX, -(totalImpulseY*(2))))
                totalImpulseY -= (totalImpulseY - 20)

            }
            else{
                sprite.physicsBody?.applyImpulse(CGVectorMake(randForVecX, randForVecY))
            }
        }
        
        */
        
         //GameScene.scene!.addChild(sprite)
        

        //determine speed of the monster
        //let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        //Create the actions
        /*let moveLeft = SKAction.moveByX(-150, y:0, duration:2.0)
        let moveUp = SKAction.moveByX(0, y: 150, duration: 2.0)
        let moveDown = SKAction.moveByX(0, y: -150, duration: 2.0)
        let moveOff = SKAction.moveByX(-200, y:0, duration: 2.0)
        let moveDiagonal = SKAction.moveByX(-150, y: 150, duration: 1.5)
        
        let actionMove = SKAction.moveTo(CGPoint(x: -sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        sprite.runAction(SKAction.sequence([moveLeft, moveDown, moveLeft, moveUp, moveLeft, moveDiagonal, moveLeft, moveDiagonal.reversedAction(), moveUp, moveLeft, moveDown, moveLeft, moveUp, moveDiagonal, moveOff, actionMoveDone]))
        */
    }
    func getVector(from : CGPoint) -> CGVector {
        let maxX : CGFloat = from.x + 300.0
        
        let randomX = random(min: 0.0, max: -300.0)
        let randomY = random(min: 0.0, max: GameScene.scene!.size.height)
        let newPoint = CGPoint(x: randomX, y:randomY)
        
        let dis : CGFloat = GameScene.getDistance(from,to: newPoint)
        
        return CGVectorMake(-500, from.y)
    }
    
            class func NormalState(){
        
    }
    func lessThanY(){
        
    }
    func greaterThanY(){
        
    }
    func impulseCheck(){
        
    }
    func getImpulseX() -> CGFloat{
        return random(min: -20.0, max: 0)
    }
    func getImpulseY() -> CGFloat{
        return random(min: -40.0, max: 40)
    }
}