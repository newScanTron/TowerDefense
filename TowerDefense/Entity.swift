//
//  Entity.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
protocol Entity
{
    //variables that both towers and enemys have
    var health: Int {get set}
    var kills: Int {get set}
    var sprite: SKSpriteNode {get set}
}