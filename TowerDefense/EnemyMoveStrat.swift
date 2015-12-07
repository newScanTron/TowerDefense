//
//  EnemyMoveStrat.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMoveStrat
{
    let moveConstant : CGFloat = 5
    var slagged : Bool = false
    
    init(){
        //Not to be initialized
    }
    
    //Base function all classes need to implement
    func Move(node : EnemyBase){
        
    }
    func outOfBounds(enemy : EnemyBase){
        let centerPoint = CGPointMake(GameScene.scene!.size.width/2, GameScene.scene!.size.height/2)
        let center = getVector(enemy.sprite.position, to: centerPoint, speed: 4)
        enemy.sprite.physicsBody?.linearDamping = 0.5
        enemy.sprite.physicsBody?.applyImpulse(center)
        
    }
    
    //Helper functions almost all strategies will need
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    func getImpulseXRand() -> CGFloat{
        return random(min: -moveConstant, max: moveConstant)
    }
    func getImpulseYPos() -> CGFloat{
        return random(min: 0, max: moveConstant)
    }
    func getImpulseYRand() -> CGFloat{
        return random(min: -moveConstant, max: moveConstant)
    }
    func getImpulseYNeg() -> CGFloat{
        return random(min: -moveConstant, max: 0)
    }
    func getImpulseXPos() -> CGFloat{
        return random(min: 0, max: moveConstant)
    }
    func getImpulseXNeg() -> CGFloat{
        return random(min: -moveConstant, max: 0)
    }
    func getVector(from : CGPoint, to : CGPoint, speed : CGFloat) -> CGVector {
        let dis : CGFloat = GameScene.getDistance(from,to: to)
        return CGVectorMake((to.x - from.x)/dis * speed, (to.y - from.y)/dis * speed)
    }
}