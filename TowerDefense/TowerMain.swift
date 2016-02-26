//
//  TowerMain.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/24/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
class TowerMain : TowerBase
{
    
    
    init(locaton: CGPoint, _attack: TowerAttackStrat, _defense : TowerDefenseStrat)
    {
        super.init(location: locaton, _attack: _attack, _defense: _defense)
       
        
    }
    
}