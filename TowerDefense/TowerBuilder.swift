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
    //this function returns a base tower with non of its straegy attibutes set.
    func BuildBaseTower(point : CGPoint)  -> TowerBase {
        let attack = TowerAttackStrat()
        let defense = TowerDefenseStrat()
        let tower = TowerBase(location: point, _attack: attack, _defense: defense)
        return tower
    }
    //function to build the main tower that will be deffended.
    func BuildMainTower(point : CGPoint) -> TowerMain
    {
        let attack = TowerMainAttackStrat()
        let defense = TowerMainDefenseStrat()
        let tower = TowerMain(locaton: point, _attack: attack, _defense: defense)
        return tower
    }
    func copyTower(tower : TowerBase) {
        pasteTower(&clipboard,source: tower)
    }
    
    func pasteTower(inout target : TowerBase) -> TowerBase? {
            let attack : TowerAttackStrat = clipboard.attack.copy()
            let defense : TowerDefenseStrat = clipboard.defense.copy()
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
            target.attackSelection = source.attackSelection
            target.defenseSelection = source.defenseSelection
            target.setAttack(attack)
            target.setDefense(defense)
            target.value = source.value
        return nil
    }
    //this method starts the chain be creating the upgradeView at the appropriate x and y location
    func addUpgradeView(tower: TowerBase, location : CGPoint, gameScene: GameScene)
    {
        var placeY: CGFloat
        var placeX: CGFloat
        let offset: CGFloat = 30.0
        let sizeOfView: CGFloat = 200
        //this set of if elses check what quatant the touch was in and moves the base location of the UIView so it will not display outside of the screen.
        if (location.y) >= CGRectGetMaxY(gameScene.frame)/2
        {
            placeY = ((location.y) - CGFloat(sizeOfView - offset))
        }
        else
        {
            placeY = (location.y - offset)
        }
        if (location.x) >= CGRectGetMaxX(gameScene.frame)/2
        {
            placeX = ((location.x) - CGFloat(sizeOfView - offset))
        }
        else
        {
            placeX = (location.x - offset)
        }
        //as mentioned elsewhere the start node has to be called first as it begins the setup process. getting the chain set up and giving it a location passing a reff in the form of an inout paramaterss
        let upgradeView = StartNode(x: (placeX), y: (placeY), tower: tower)
        //The tower builder dosen't know about the nodes it just need to call this function.  Each node knows how to display their information based on the inheratence of upgradeView which inherets the upgradeNode.  this allows the way the view is displayed independantly of where it is being implemented.
        gameScene.view?.addSubview(upgradeView.GetView())

        
    }
    
}