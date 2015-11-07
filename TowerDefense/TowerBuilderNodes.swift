//
//  AttackNode.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
//set attack range node
class AttackSetRange: UpgradeNode
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
    func upgrade()
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            
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
    func upgrade()
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            
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
    func upgrade()
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            
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
    func upgrade()
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            
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
    func upgrade()
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            
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
    func upgrade()
    {
        if self.nextNode != nil
        {
            
        }
        else
        {
            
        }
    }
    
}