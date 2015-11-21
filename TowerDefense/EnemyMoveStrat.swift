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
    
    init(){
        //Not to be initialized
    }
    
    //Base function all classes need to implement
    func Move(node : EnemyBase){
        
    }
    
    //Helper functions almost all strategies will need
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    func getImpulseX() -> CGFloat{
        return random(min: -20.0, max: -10)
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
}