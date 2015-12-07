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
        //attack.parent = tower
        //defense.parent = tower
        
        return tower
    }
    
    func copyTower(tower : TowerBase) {
        pasteTower(&clipboard,source: tower)
    }
    
    func pasteTower(inout target : TowerBase) -> TowerBase? {
            let attack : TowerAttackStrat = clipboard.attack.copy()
            let defense : TowerDefenseStrat = clipboard.defense.copy()
            //attack.parent = target
            //defense.parent = target
            
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
            //attack.parent = target
            //defense.parent = target
            
            target.attackSelection = source.attackSelection
            target.defenseSelection = source.defenseSelection
            target.setAttack(attack)
            target.setDefense(defense)
            target.value = source.value
        return nil
    }
    
    func addUpgradeView(tower: TowerBase, location : CGPoint, gameScene: GameScene)
    {
        var placeY: CGFloat
        var placeX: CGFloat
        if (location.y) >= CGRectGetMaxY(gameScene.frame)/2
        {
            placeY = ((location.y) - CGFloat(200.0))
            
        }
        else
        {
            placeY = (location.y)
            
        }
        if (location.x) >= CGRectGetMaxX(gameScene.frame)/2
        {
            placeX = ((location.x) - CGFloat(200.0))
            
        }
        else
        {
            placeX = (location.x)
            
        }
        var upgradeView = StartNode(x: (placeX), y: (placeY), tower: tower)
        //getting the chain set up and giving it a location passing a reff in the form of an inout paramaterss
        //setUpChain(&upgradeView, x: placeX, y: placeY)
        //The Game scene is only responsible for adding the first node to itself.  Each node knows how to display their information an
        gameScene.view?.addSubview(upgradeView.GetView())
        //if we find that we have touched inside one of the towers we want to return from this function because taht is all we are interested in.
        
    }
    
}