//
//  TowerAttackStrat.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerDefenseStrat
{
    var range : CGFloat = 0
    var amount : CGFloat = 0
    var parent : TowerBase? = nil
    
    var rangeLevel : Int = 0
    var amountLevel : Int = 0
    
    var imageName : String = "defaultBase"
    
    
    
    init () {
        //fatalError("Don't instantiate the base class!")
    }
    
    func setRangeLevel(level : Int) {}
    func setAmountLevel(level : Int) {}
    
    
    func Defend() {
       //fatalError("Don't call Defend() on the base class!")
    }
    
    func Die() {
        
        //print("Don't call Die() on the base class!")
    }
    
    func copy() -> TowerDefenseStrat {
        let strat = TowerDefenseStrat()
        strat.setRangeLevel(rangeLevel)
        strat.setAmountLevel(amountLevel)
        return strat
    }
    
}