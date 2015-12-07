//
//  UpgradeNode.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit

//this protocol represents the base node of the upgrade chain
protocol UpgradeNode{
    var nextNode: UpgradeNode? {get set}

    //pass the upgradeObj to the next node in the chain
    func setNextNode(node: UpgradeNode)
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    
}


//fucntion to add the upgradeView
//func addUpgradeView(tower: TowerBase, location : CGPoint, gameScene: GameScene)
//{
//    var placeY: CGFloat
//    var placeX: CGFloat
//    if (location.y) >= CGRectGetMaxY(gameScene.frame)/2
//    {
//        placeY = ((location.y) - CGFloat(200.0))
//        
//    }
//    else
//    {
//        placeY = (location.y)
//        
//    }
//    if (location.x) >= CGRectGetMaxX(gameScene.frame)/2
//    {
//        placeX = ((location.x) - CGFloat(200.0))
//        
//    }
//    else
//    {
//        placeX = (location.x)
//        
//    }
//    var upgradeView = StartNode(x: (placeX), y: (placeY), tower: tower)
//    //getting the chain set up and giving it a location passing a reff in the form of an inout paramaterss
//    setUpChain(&upgradeView, x: placeX, y: placeY)
//    //The Game scene is only responsible for adding the first node to itself.  Each node knows how to display their information an
//    gameScene.view?.addSubview(upgradeView.GetView())
//    //if we find that we have touched inside one of the towers we want to return from this function because taht is all we are interested in.
//    
//}
//
//
////func that will set up the chain of reponsibility for updating
//func setUpChain(inout node: StartNode, x: CGFloat , y: CGFloat)
//{
//   
//    
////    //initialize the nodes of the chain
////    let setRange
////    let setDamageNode = AttackSetDamage(x: x, y: y)
////    let fireDeleyNode = SetFireDelay(x: x, y: y)
////    let setSpeed = SetSpeed(x: x, y: y)
////    let deffenseSetRange = DeffenseSetRange(x: x, y: y)
////    let deffenseSetAmount = DeffenseSetAmount(x: x, y: y)
////    
////    //set all the nodes to the seccuessor
////    node.setNextNode(setDamageNode)
////    setDamageNode.setNextNode(fireDeleyNode)
////    fireDeleyNode.setNextNode(setSpeed)
////    setSpeed.setNextNode(deffenseSetRange)
////    
////    
////    deffenseSetRange.setNextNode(deffenseSetAmount)
////    //deffenseSetAmount is not set to have a node following it so it
//    
//}