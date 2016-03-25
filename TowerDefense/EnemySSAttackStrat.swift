//
//  EnemySSAttackStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 3/6/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//


import Foundation

class EnemySSAttackStrat: EnemyAttackStrat {
    override func Attack() {
        
    }
    //Die function that cleans up boss death
    override func Die()  {

        let exp : Explosion = Explosion(_radius: 120, _damage: 80)
        exp.trigger(parent!.sprite.position)
        
        
    }
}