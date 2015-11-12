//
//  UpgradeNode.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation


//this protocol represents the base node of the upgrade chain
protocol UpgradeNode{
    var nextNode: UpgradeNode? {get set}

    //pass the upgradeObj to the next node in the chain
    func setNextNode(node: UpgradeNode)
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
}