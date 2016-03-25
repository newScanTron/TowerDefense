//
//  TowerAttackSideScroll.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 3/23/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class TowerAttackSideScroll : TowerAttackStrat {
    
    override init () {
        super.init()
        imageName = "Spaceship"
    }
    
    override func Attack(tower: TowerBase) {
        let passTarget = SKSpriteNode()
        passTarget.position = CGPointMake(tower.sprite.position.x + 100, tower.sprite.position.y)
        
        let b : Bullet = Bullet(_shooter: tower, _target: passTarget, _speed: 330, _damage: 120, size: 15, shotByEnemy: false)
    }
}

