//
//  StateContext.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/15/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
class StateContext {

    var daState : StateChecker = StateNormal()
    
    init(){
        setState(StateNormal())
    }
    
    func setState(newState : StateChecker){
        daState = newState
    }
    
    func setImpulse(sprite: SKSpriteNode){
        daState.SetImpulse(self, sprite: sprite)
    }
    
}
