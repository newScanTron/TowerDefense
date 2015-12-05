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
    var nodeData = ["Zero", "Close", "Proximity", "Ranged"]
    init(x: CGFloat, y: CGFloat, tower: TowerBase)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.tower = tower
        mainLabel.text = "Tower Range"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        //changing the picker color to something more in line with what is being choosen all just to make it change so more than the text changes.
        upgradeSelection.backgroundColor = UIColor(red: 0.0, green: 0.65, blue: 0.75, alpha: 0.8)
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
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    //function with each of the this method will do the actuall calling of things that effect the player gold
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        checkPicker(row)
    }
    //function to check row of picker and ajust player gold accordinly
    func checkPicker(row: Int)
    {
        
        
        
        let changeAmount = CGFloat(row*3)
        let cost = row * 100
        //if tower.attack.ragne is greater or less than proposed change it and the player has enough gold to upgrade the tower.
        if self.tower?.attack.range < changeAmount && appDelegate.user.gold >= cost
        {
            playerLabel.text = nodeData[row]
            moneySpent = cost
            self.tower?.attack.range += changeAmount
        }
        else if self.tower?.attack.range >= changeAmount
        {
            //going to give money back to the player if they downgrade
            
            let refund = changeAmount - (self.tower?.attack.range)!
            moneySpent = Int(refund)
            self.tower?.attack.range -= changeAmount
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
    var nodeData = ["None", "low", "med", "hight"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Damgae Amount"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        upgradeSelection.backgroundColor = UIColor(red: 0.6, green: 0.2, blue: 0.1, alpha: 0.8)
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
        
        let changeAmount = CGFloat(row)*1.4
        let cost = row * 100
        if appDelegate.user.gold >= cost && self.tower?.attack.damage < changeAmount
        {
            playerLabel.text = nodeData[row]
            self.tower?.attack.damage = changeAmount
            moneySpent = cost
        }
        else if self.tower?.attack.damage >= changeAmount
        {
            
            let refund = changeAmount - (self.tower?.attack.damage)!
            moneySpent = Int(refund)
            self.tower?.attack.damage -= changeAmount
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
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
    var nodeData = ["none", "fast", "medium", "slow"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Fire Rate"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        upgradeSelection.backgroundColor = UIColor(red: 0.5, green: 0.3, blue: 0.2, alpha: 0.8)
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
        let cost = row * 100
        //changeAmount represents the biggest diference between the different nodes
        let changeAmount = CGFloat(Double(nodeData.count-row) * 0.5)
        if appDelegate.user.gold >= cost && self.tower?.attack.fireDelay < changeAmount
        {
            playerLabel.text = nodeData[row]
            //since this arrary starts with the best option
            moneySpent = (nodeData.count-row) * 100
            //this is very simple way to see that the fireDeley is being ajusted.
            self.tower?.attack.fireDelay += changeAmount
        }
        else if self.tower?.attack.fireDelay >= changeAmount
        {
            let refund = changeAmount - (self.tower?.attack.fireDelay)!
            moneySpent = Int(refund)
            self.tower?.attack.fireDelay -= changeAmount
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
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
    var nodeData = ["not set", "Slow", "Med", "Fast"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Bullet Speed"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        
        upgradeSelection.backgroundColor = UIColor(red: 0.7, green: 0.3, blue: 0.7, alpha: 0.8)
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
        if appDelegate.user.gold >= (row) * 100
        {
            playerLabel.text = nodeData[row]
            self.tower?.attack.speed = CGFloat((Double(row) * 5 * 55.15))
            moneySpent = (row) * 100
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
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
    var nodeData = ["not set", "close", "med", "Far"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Defense Range"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        upgradeSelection.backgroundColor = UIColor(red: 0.9, green: 0.6, blue: 0.0, alpha: 0.8)
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
        if appDelegate.user.gold >= (row) * 100
        {
            playerLabel.text = nodeData[row]
            self.tower?.defense.range = CGFloat((Double(row) * 2.5))
            moneySpent = (row) * 100
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
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
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
    var nodeData = ["nont", "low", "med", "high"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Deffense Set Amount"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        upgradeSelection.backgroundColor = UIColor(red: 0.0, green: 0.9, blue: 0.9, alpha: 0.8)
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
        if appDelegate.user.gold >= (row) * 100
        {
            playerLabel.text = nodeData[row]
            self.tower?.defense.amount = CGFloat((Double(row) * 3.5))
            moneySpent = (row) * 100
        }
        else
        {
            playerLabel.text = "not enough gold"
        }
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
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