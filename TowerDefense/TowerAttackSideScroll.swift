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

    var sprite :SKSpriteNode = SKSpriteNode()
    
    override init () {
        super.init()
        imageName = "Spaceship"
 
    }
    
    override func Attack(tower: TowerBase) {
        let passTarget = SKSpriteNode()
        passTarget.position = CGPointMake(tower.attackSprite.position.x + 100, tower.attackSprite.position.y)
        
        let b : Bullet = Bullet(_shooter: tower, _target: passTarget, _speed: 530, _damage: 20, size: 15, shotByEnemy: false)
    }

}

