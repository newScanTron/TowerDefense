//
//  Entity.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
class Entity
{
    //variables that both towers and enemys have
    var maxHealth = 100
    var health: CGFloat = 100
    var kills: Int = 0
    var sprite: SKSpriteNode
    var healthLabel :SKLabelNode
    
    init() {
        sprite = SKSpriteNode()
        healthLabel = SKLabelNode()
    }
}