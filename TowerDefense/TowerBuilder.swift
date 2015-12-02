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
    func BuildTower(point: CGPoint) -> TowerBase?
    {
        let attack = TowerAttackBasic()
        attack.range = 300

        attack.damage = 1
        attack.fireDelay = 1 //1
        attack.speed = 100 //100
        
        
        let defense = TowerDefenseSlag()
        defense.range = 100
        defense.amount = 2
        
        
        let tower = TowerBase(location: point, _attack: attack, _defense: defense)
        attack.parent = tower
        defense.parent = tower
        tower.sprite.zPosition = ZPosition.tower
        tower.sprite.name = "tower"
        
        if GameScene.addGold(-100) {
            return tower
        }
        
        return nil
    }
    func BuildPulseTower(point: CGPoint) -> TowerBase?
    {
        
        
        let attack = TowerAttackPulse()
        attack.range = 100
        attack.damage = 30
        attack.fireDelay = 3 //1
        attack.speed = 10 //100
        
        let defense = TowerDefenseSlag()
        defense.range = 100
        defense.amount = 2
        
        
        let tower = TowerBase(location: point, _attack: attack, _defense: defense)
        attack.parent = tower
        defense.parent = tower
        tower.sprite.zPosition = ZPosition.tower
        tower.sprite.name = "tower"
        
        
        if GameScene.addGold(-100) {
            return tower
        }
        
        return nil
    }

    func attackSetRange(range: Int)
    {
        
    }
    func attackSetDamage(damage: Int)
    {
        
    }
    func setFireDelay(delay: Int)
    {
        
    }
    func setSpeed(speed: Int)
    {
        
    }
    func deffenseSetRange(range: Int)
    {
        
    }
    func deffenseSetAmount(amount: Int)
    {
        
    }
}