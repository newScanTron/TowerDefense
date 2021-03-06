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
        let mainTower = TowerMain(locaton: point, _attack: attack, _defense: defense)
        return mainTower
    }

    
    func BuildBaseShip()  -> TowerBase {
        let attack = TowerAttackSideScroll()
        let defense = TowerDefenseSideScroll()
        let tower = TowerBase(location: CGPointMake(200, 200), _attack: attack, _defense: defense)
        

        tower.sprite.physicsBody?.dynamic = false
        tower.sprite.physicsBody?.mass = 1
        tower.sprite.physicsBody?.restitution = 1.0
        tower.sprite.physicsBody?.linearDamping = 1.0
        tower.sprite.physicsBody?.angularDamping = 1.0
        tower.sprite.physicsBody?.allowsRotation = false
        tower.sprite.zPosition = ZPosition.tower-10
        tower.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(10, 10))
        //tower.sprite.zRotation = CGFloat(-M_PI/2)
        tower.attackSprite.zRotation = CGFloat(-M_PI/2)
        tower.sprite.xScale = 0.15
        tower.sprite.yScale = 0.15
        tower.attackSprite.xScale = 0.15
        tower.attackSprite.yScale = 0.15
        tower.attackSprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(25, 25))
        tower.attackSprite.physicsBody?.categoryBitMask = CategoryMask.Tower
        tower.attackSprite.physicsBody?.collisionBitMask = CollisionMask.Tower
        tower.attackSprite.physicsBody?.contactTestBitMask = ContactMask.Tower
  //      SideScrolScene.scene?.addChild(tower.sprite)
        
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
            let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        var placeY: CGFloat
        var placeX: CGFloat
        let offset: CGFloat = 30.0
        let sizeOfView: CGFloat = 200
        //this set of if elses check what quatant the touch was in and moves the base location of the UIView so it will not display outside of the screen.
        if (location.y) >= CGRectGetMaxY(appDelegate!.gameScene!.frame)/2
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
    //upgrade view for the main ship/drilling rig
    func addMainUpgradView(tower: TowerBase, location : CGPoint, gameScene: SKScene)
    {
        var placeY: CGFloat
        var placeX: CGFloat
        let offset: CGFloat = 0.0
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
        let mainHUD = MainTowerHUD(x: placeX, y: placeY)
        gameScene.view?.addSubview(mainHUD)
    }
}