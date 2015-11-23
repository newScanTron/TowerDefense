//
//  AttackNode.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
//set attack range node.  Each of these noodes extend UpgradeView which is a custom UIView class i have created to give each of these noedes a uniform interface.  Upgrade node 
//is the protocol that represents the Processing elements structure that each of these nodes are the concrete implemntation of.  UIPickerViewDelegate and UIPickerViewDataSource are 
//part of the UIKit framework needed for iOS developments
class AttackSetRange: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    //each node needs a towerBase variable because we need access to it outside of the upgrade function
    var tower: TowerBase?
    var nodeData = ["Close", "Proximity", "Ranged"]
    init(x: CGFloat, y: CGFloat, tower: TowerBase)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.tower = tower
        mainLabel.text = "Tower Range"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        
        
    }

    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    //functions conforming to the UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nodeData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nodeData[row]
    }
    //function
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerLabel.text = nodeData[row]
    }
    
    func setNextNode(node: UpgradeNode)
    {
         self.nextNode = node
    }
    //fucntion to begin the upgrade request down the chain
    func startUpgradeChain()
    {
        
        
        
        if self.nextNode != nil
        {
            
            upgrade(self.tower!)
        }
        else
        {
        
        }
        self.removeFromSuperview()
        
    }
    
    //the method that all nodes will implement in different fashions. Taking values from the UIPickerView to select the correct array elements.
    func upgrade(tower: TowerBase)
    {
        self.tower!.attack.range = 2
        
        GameScene.scene?.view?.addSubview(self)

        self.tower = tower
      
        self.nextNode?.upgrade(tower)
        
    }
 
}
//set Attack damage
class AttackSetDamage: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
   
    var tower: TowerBase?
    var nodeData = ["attack", "set", "up"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "this is the Set Attach Damage Node"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
    }

    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nodeData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nodeData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerLabel.text = nodeData[row]
    }
    func startUpgradeChain()
    {
        if self.nextNode != nil
        {
            
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
        self.removeFromSuperview()
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {

        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
       
    }
    
}
//set Fire delay
class SetFireDelay: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    
    var tower: TowerBase?
    var nodeData = ["fast", "medium", "slow"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Fire Node"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
    }
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nodeData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nodeData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerLabel.text = nodeData[row]
        //this is very simple way to see that the fireDeley is being ajusted.
        self.tower?.attack.fireDelay = CGFloat((Double(row)+1 * 0.5))
    }
    func startUpgradeChain()
    {
        if self.nextNode != nil
        {
            
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
        self.removeFromSuperview()
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {

        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
    }
    
}
//set the speed of the the bullet?
class SetSpeed: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    
    var tower: TowerBase?
    var nodeData = ["speed", "deley", "up"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Fire Node"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
    }
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nodeData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nodeData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerLabel.text = nodeData[row]
    }
    func startUpgradeChain()
    {
        if self.nextNode != nil
        {
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
           
        }
         self.removeFromSuperview()
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        print("Set Speed Node")
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
    }
    
}

class DeffenseSetRange: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    
    var tower: TowerBase?
    var nodeData = ["defnece", "Range", "up"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Fire Node"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
    }
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nodeData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nodeData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerLabel.text = nodeData[row]
    }
    func startUpgradeChain()
    {
        if self.nextNode != nil
        {
       
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
        self.removeFromSuperview()
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
   
    }
    
}
//Set amout of deffenset
class DeffenseSetAmount: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    
    var tower: TowerBase?
    var nodeData = ["Deffense", "Amount", "up"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Deffense Set Amount Node"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
    }
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nodeData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nodeData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerLabel.text = nodeData[row]
    }
    func startUpgradeChain()
    {
        if self.nextNode != nil
        {
           
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
        self.removeFromSuperview()
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
    }
    
}