//
//  StateChecker.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/15/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class StateChecker{
    init(){}
    func SetImpulse(state : StateContext, sprite: SKSpriteNode){
        
    }
    func getImpulseX() -> CGFloat{
        return random(min: -20.0, max: 0)
    }
    func getImpulseYPos() -> CGFloat{
        return random(min: 0, max: 20)
    }
    func getImpulseY() -> CGFloat{
        return random(min: -20, max: 20)
    }
    func getImpulseYNeg() -> CGFloat{
        return random(min: -20, max: 0)
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
}

class StateYLow: StateChecker{
    override func SetImpulse(state : StateContext, sprite: SKSpriteNode) {
        sprite.physicsBody?.friction = 40.0
        sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-1), (getImpulseYPos()*(3))))
        if(sprite.position.y > 10){
            sprite.physicsBody?.friction = 0.0
            state.setState(StateNormal())
         }
    }
}

class StateYHigh: StateChecker{
    override func SetImpulse(state : StateContext, sprite: SKSpriteNode) {
        sprite.physicsBody?.friction = 40.0
        sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-1), (getImpulseYNeg()*(3))))
        if (sprite.position.y < 758){
            state.setState(StateNormal())
            sprite.physicsBody?.friction = 0.0
        }
    }
}


class StateNormal: StateChecker{
    override func SetImpulse(state: StateContext, sprite: SKSpriteNode) {
        if (sprite.position.y <= 10){
            state.setState(StateYLow())
        }
        else if(sprite.position.y >= 758){
            state.setState(StateYHigh())
        }
        else if (sprite.position.x < 200){
            sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX()*(-3), getImpulseY()))
        }
        else {
            sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseX(), getImpulseY()))
        }
    }
}