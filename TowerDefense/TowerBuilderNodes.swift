//
//  AttackNode.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
//set attack range node
class AttackSetRange: UpgradeView, UpgradeNode
{
    var nextNode: UpgradeNode?
    private var tower: TowerBase?
    
    init(x: CGFloat, y: CGFloat, tower: TowerBase)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.tower = tower
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
    }

    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    func setNextNode(node: UpgradeNode)
    {
         self.nextNode = node
    }
    
    //this node will be the initial node for our chain
    func startUpgradeChain(){
        
        self.mainLabel.text = "this is the Set Attach Range Node"
        

    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        tower.attack.range = 2
        
        self.mainLabel.text = "this is the Set Attach Range Node"
        
        
        if self.nextNode != nil
        {
            
        }
        else
        {
            self.nextNode?.upgrade(tower)
        }
    }
 
}
//set Attack damage
class AttackSetDamage: UpgradeNode
{
    var nextNode: UpgradeNode?
    
    init()
    {
        self.nextNode = nil
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            self.nextNode?.upgrade(tower)
        }
    }
    
}
//set Fire delay
class SetFireDelay: UpgradeNode
{
    var nextNode: UpgradeNode?
    
    init()
    {
        self.nextNode = nil
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            self.nextNode?.upgrade(tower)
        }
    }
    
}
//set the speed of the the bullet?
class SetSpeed: UpgradeNode
{
    var nextNode: UpgradeNode?
    
    init()
    {
        self.nextNode = nil
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            self.nextNode?.upgrade(tower)
        }
    }
    
}
class DeffenseSetRange: UpgradeNode
{
    var nextNode: UpgradeNode?
    
    init()
    {
        self.nextNode = nil
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            self.nextNode?.upgrade(tower)
        }
    }
    
}
//Set amout of deffenset
class DeffenseSetAmount: UpgradeNode
{
    var nextNode: UpgradeNode?
    
    init()
    {
        self.nextNode = nil
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            self.nextNode?.upgrade(tower)
        }
    }
    
}