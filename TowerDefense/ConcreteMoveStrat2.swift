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
    
    let moveStrat = "concrete2"
    override init() {}
    override func Move(sprite: SKSpriteNode, scene: SKScene){
        //determine where to spawn the bison along the Y axis
        let actualY = random(min: sprite.size.height/2, max: scene.size.height - sprite.size.height/2)
        
        //Position the bison slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        sprite.position = CGPoint(x: scene.size.width + sprite.size.width/2, y:actualY)
        //determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        //Create the actions
        let moveLeft = SKAction.moveByX(-150, y:0, duration:1.0)
        let moveUp = SKAction.moveByX(0, y: 150, duration: 1.0)
        let moveDown = SKAction.moveByX(0, y: -150, duration: 1.0)
        let moveOff = SKAction.moveByX(-200, y:0, duration: 1.0)
        let moveDiagonal = SKAction.moveByX(-150, y: 150, duration: 0.5)
        
        let actionMove = SKAction.moveTo(CGPoint(x: -sprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        sprite.runAction(SKAction.sequence([moveLeft, moveLeft, moveUp, moveLeft, moveDown, moveDiagonal, moveOff, actionMoveDone]))
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    func getMoveStrat() -> String
    {
        return moveStrat
    }
}