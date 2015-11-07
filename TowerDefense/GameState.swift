//
//  GameState.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation

struct GameState {
    var xp: Int = 0
    var gold: Int = 0
    var towers : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    var enemies : [EnemyBase] = [EnemyBase]()
    //constructor
    init(xp: Int, gold: Int, towers: [TowerBase], enemies: [EnemyBase])
    {
        self.xp = xp
        self.gold = gold
        self.towers = towers
        self.enemies = enemies
    }
}