//
//  EnemyAttackStrat.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

protocol EnemyAttackStrat
{
    func Attack(e: EnemyBase, t: SKNode, s: SKScene)
}