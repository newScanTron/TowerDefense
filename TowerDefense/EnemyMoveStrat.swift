//
//  EnemyMoveStrat.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

protocol EnemyMoveStrat
{

    func Move(sprite: SKSpriteNode, scene: SKScene)
    func getMoveStrat() -> String

}