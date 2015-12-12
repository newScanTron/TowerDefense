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
    
    var rangeLevel : Int = 0
    var amountLevel : Int = 0
    
    var imageName : String = "defaultBase"
    
    
    
    init () {}
    func setRangeLevel(level : Int) {}
    func setAmountLevel(level : Int) {}
    func Defend(tower : TowerBase) {}
    func Die(tower : TowerBase) {}
    
    func copy() -> TowerDefenseStrat {
        let strat = TowerDefenseStrat()
        strat.setRangeLevel(rangeLevel)
        strat.setAmountLevel(amountLevel)
        return strat
    }
    
}