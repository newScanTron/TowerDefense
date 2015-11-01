//
//  TowerBuilder.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
class TowerBuilder
{
    init() {}
    
    //build method
    func BuildTower(point: CGPoint) -> TowerBase
    {
        let tower = TowerBase(location: point)
        return tower
    }
}