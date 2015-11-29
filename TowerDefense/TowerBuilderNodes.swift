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
    var moneySpent = 0
    //this array represents the datasource for the UIPickerView
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
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
    //function with each of the this method will do the actuall calling of things that effect the player gold
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.user.gold >= (row+1) * 100
        {
            playerLabel.text = nodeData[row]
            self.tower?.attack.range = (row+2)*3
            moneySpent = (row+1) * 100
            print(appDelegate.user.gold)
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
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
            //this is kinda goofy cus this first node calls these two methods diffrently than the onther nodes that follow this one.
            upgrade(self.tower!)
        }
        else{ }
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        self.removeFromSuperview()
        
    }
    
    //the method that all nodes will implement in different fashions. Taking values from the UIPickerView to select the correct array elements.
    func upgrade(tower: TowerBase)
    {
        
        GameScene.scene?.view?.addSubview(self)

        self.tower = tower
      
        self.nextNode?.upgrade(tower)
        
    }
 
}
//set Attack damage
class AttackSetDamage: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    var moneySpent = 0
    var tower: TowerBase?
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var nodeData = ["low", "med", "hight"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Damgae Amount"
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
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.user.gold >= (row+1) * 100
        {
        playerLabel.text = nodeData[row]
        self.tower?.attack.damage = CGFloat(row+2)*1.4
        moneySpent = (row+1) * 100
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
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
         appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
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
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var moneySpent = 0
    var tower: TowerBase?
    var nodeData = ["fast", "medium", "slow"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Fire Rate"
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
        
        if appDelegate.user.gold >= (row+1) * 100
        {
        playerLabel.text = nodeData[row]
            moneySpent = (row+1) * 100
        //this is very simple way to see that the fireDeley is being ajusted.
            self.tower?.attack.fireDelay = CGFloat((Double(row)+1 * 0.5))
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
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
            appDelegate.user.gold -= moneySpent
         appDelegate.updateMyLabel()
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
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var tower: TowerBase?
    var moneySpent = 0
    var nodeData = ["Slow", "Med", "Fast"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Bullet Speed"
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
    //intersting fucntion to how the tower gets affected.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.user.gold >= (row+1) * 100
        {
        playerLabel.text = nodeData[row]
        self.tower?.attack.speed = CGFloat(((Double(row)+1) * 5 * 55.15))
            moneySpent = (row+1) * 100
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
    }
    func startUpgradeChain()
    {
        if self.nextNode != nil
        {
            
            self.nextNode?.upgrade(self.tower!)
        }
        else{}
        appDelegate.user.gold -= moneySpent
         appDelegate.updateMyLabel()
        self.removeFromSuperview()
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
    }
    
}

class DeffenseSetRange: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var tower: TowerBase?
    var moneySpent = 0
    var nodeData = ["close", "med", "Far"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Defense Range"
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
        if appDelegate.user.gold >= (row+1) * 100
        {
        playerLabel.text = nodeData[row]
        self.tower?.defense.range = CGFloat((Double(row)+1 * 2.5))
            moneySpent = (row+1) * 100
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
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
         appDelegate.user.gold -= moneySpent
         appDelegate.updateMyLabel()
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
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var tower: TowerBase?
    var moneySpent = 0
    var nodeData = ["low", "med", "high"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Deffense Set Amount"
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
        if appDelegate.user.gold >= (row+1) * 100
        {
        playerLabel.text = nodeData[row]
        self.tower?.defense.amount = CGFloat((Double(row)+1 * 3.5))
        moneySpent = (row+1) * 100
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
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
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        self.removeFromSuperview()
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
    }
    
}