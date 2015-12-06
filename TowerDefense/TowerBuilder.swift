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
    var clipboard : TowerBase?
    
    init() {}
    
    func BuildBaseTower(point : CGPoint)  -> TowerBase {
        let attack = TowerAttackStrat()
        let defense = TowerDefenseStrat()
        let tower = TowerBase(location: point, _attack: attack, _defense: defense)
        attack.parent = tower
        defense.parent = tower
        
        return tower
    }
    
    func copyTower(tower : TowerBase) {
        clipboard = tower
    }
    
    func pasteTower(point : CGPoint) -> TowerBase? {
        if (clipboard != nil) {
            
            let tower : TowerBase = BuildBaseTower(point)
            
            var attack : TowerAttackStrat = TowerAttackStrat()
            switch (clipboard!.attackSelection) {
            case 0:
                // Attack strat is already base class
                break
            case 1:
                // Clipboard's attack strat is Basic (Cannon)
                attack = TowerAttackBasic()
                break
            case 2:
                // Clipboard's attack strat is Pulse
                attack = TowerAttackPulse()
                break
            default:
                print("Invalid Attack Selection")
                break
            }
            
            attack.setDamageLevel(clipboard!.attack.damageLevel)
            attack.setRangeLevel(clipboard!.attack.rangeLevel)
            attack.setFireDelayLevel(clipboard!.attack.fireDelayLevel)
            attack.setSpeedLevel(clipboard!.attack.speedLevel)
            
            
            var defense : TowerDefenseStrat = TowerDefenseStrat()
            switch (clipboard!.defenseSelection) {
            case 0:
                // Defense strat is already base class
                break
            case 1:
                // Clipboard's defense strat is Heal
                defense = TowerDefenseHeal()
                break
            case 2:
                // Clipboard's attack strat is Slag
                defense = TowerDefenseSlag()
                break
            default:
                print("Invalid Defense Selection")
                break
            }
            
            defense.setAmountLevel(clipboard!.defense.amountLevel)
            defense.setRangeLevel(clipboard!.defense.rangeLevel)
            
            tower.attackSelection = clipboard!.attackSelection
            tower.defenseSelection = clipboard!.defenseSelection
            attack.parent = tower
            defense.parent = tower
        
            return tower
        }
        return nil
    }
    
}