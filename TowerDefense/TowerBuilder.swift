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
    var clipboard : TowerBase
    
    init() {
        clipboard = TowerBase(location: CGPoint(x: 0,y:0), _attack: TowerAttackStrat(), _defense: TowerDefenseStrat())
    }
    
    func BuildBaseTower(point : CGPoint)  -> TowerBase {
        let attack = TowerAttackStrat()
        let defense = TowerDefenseStrat()
        let tower = TowerBase(location: point, _attack: attack, _defense: defense)
        //attack.setParent(tower)
        attack.parent = tower
        defense.parent = tower
        
        return tower
    }
    
    func copyTower(tower : TowerBase) {
        pasteTower(&clipboard,source: tower)
    }
    
    func pasteTower(inout target : TowerBase) -> TowerBase? {
            let attack : TowerAttackStrat = clipboard.attack.copy()
            let defense : TowerDefenseStrat = clipboard.defense.copy()
            attack.parent = target
            defense.parent = target
            
            target.attackSelection = clipboard.attackSelection
            target.defenseSelection = clipboard.defenseSelection
            target.setAttack(attack)
            target.setDefense(defense)
            target.value = clipboard.value
        return nil
    }
    
    func pasteTower(inout target : TowerBase, source : TowerBase) -> TowerBase? {
            let attack : TowerAttackStrat = source.attack.copy()
            let defense : TowerDefenseStrat = source.defense.copy()
            attack.parent = target
            defense.parent = target
            
            target.attackSelection = source.attackSelection
            target.defenseSelection = source.defenseSelection
            target.setAttack(attack)
            target.setDefense(defense)
            target.value = source.value
        return nil
    }
    
}