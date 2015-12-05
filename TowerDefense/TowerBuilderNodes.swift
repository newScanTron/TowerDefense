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
    var moneySpent = 0
    var previousSelection : Int = 0
    var tower: TowerBase?
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var nodeData = ["None", "Close", "Proximity", "Ranged"]
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Range Amount"
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
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            playerLabel.text = nodeData[row]
            self.tower?.attack.setRangeLevel(row)
            moneySpent = (row-previousSelection) * 100
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
        previousSelection = tower.attack.rangeLevel
        
    }
    
}

//class AttackSetRange: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
//{
//    var nextNode: UpgradeNode?
//    //each node needs a towerBase variable because we need access to it outside of the upgrade function
//    var tower: TowerBase?
//    var moneySpent = 0
//    var previousSelection : Int = 0
//    //this array represents the datasource for the UIPickerView
//    let appDelegate =
//    UIApplication.sharedApplication().delegate as! AppDelegate
//    var nodeData = ["Zero", "Close", "Proximity", "Ranged"]
//    init(x: CGFloat, y: CGFloat, tower: TowerBase)
//    {
//        super.init(x: x, y: y)
//        self.nextNode = nil
//        self.tower = tower
//        mainLabel.text = "Tower Range"
//        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
//        upgradeSelection.dataSource = self
//        upgradeSelection.delegate = self
//        previousSelection = self.tower!.attack.rangeLevel
//        
//    }
//
//    required init?(coder aDecoder: (NSCoder!)) {
//        super.init(coder: aDecoder)
//    }
//    //functions conforming to the UIPickerView DataSource
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return nodeData.count
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return nodeData[row]
//        
//    }
//    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
//        let pickerLabel = UILabel()
//        let titleData = nodeData[row]
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
//        pickerLabel.attributedText = myTitle
//        return pickerLabel
//    }
//    //function with each of the this method will do the actuall calling of things that effect the player gold
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if appDelegate.user.gold >= (row-previousSelection) * 100
//        {
//            playerLabel.text = nodeData[row]
//            self.tower?.attack.setRangeLevel(row)
//            moneySpent = (row - previousSelection) * 100
//            print(appDelegate.user.gold)
//        }
//        else
//        {
//            playerLabel.text = "not enough gold"
//
//        }
//    }
//    
//    func setNextNode(node: UpgradeNode)
//    {
//         self.nextNode = node
//    }
//    //fucntion to begin the upgrade request down the chain
//    func startUpgradeChain()
//    {
//        
//        if self.nextNode != nil
//        {
//            //this is kinda goofy cus this first node calls these two methods diffrently than the onther nodes that follow this one.
//            upgrade(self.tower!)
//        }
//        else{ }
//        appDelegate.user.gold -= moneySpent
//        appDelegate.updateMyLabel()
//        self.removeFromSuperview()
//        
//    }
//    
//    //the method that all nodes will implement in different fashions. Taking values from the UIPickerView to select the correct array elements.
//    func upgrade(tower: TowerBase)
//    {
//        
//        GameScene.scene?.view?.addSubview(self)
//
//        self.tower = tower
//        
//        previousSelection = self.tower!.attack.rangeLevel
//      
//        self.nextNode?.upgrade(tower)
//        
//    }
// 
//}


//set Attack damage
class AttackSetDamage: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    var moneySpent = 0
    var previousSelection : Int = 0
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
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
        playerLabel.text = nodeData[row]
        self.tower?.attack.setDamageLevel(row)
        moneySpent = (row-previousSelection) * 100
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
        previousSelection = tower.attack.damageLevel
       
    }
    
}
//set Fire delay
class SetFireDelay: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var moneySpent = 0
    var previousSelection : Int = 0
    var tower: TowerBase?
    //var nodeData = ["not set", "fast", "medium", "slow"]
    var nodeData = ["slow", "medium", "fast","ludacris"]
    var values : [CGFloat] = [3,2,1,0.5]
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
        
        if appDelegate.user.gold >= (row - previousSelection) * 100
        {
            playerLabel.text = nodeData[row]
            //since this arrary starts with the best option
            //moneySpent = (nodeData.count-row) * 100
            moneySpent = (row-previousSelection) * 100
            //this is very simple way to see that the fireDeley is being ajusted.
           self.tower?.attack.setFireDelayLevel(row)
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
        previousSelection = tower.attack.fireDelayLevel
        
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
    var previousSelection : Int = 0
    var nodeData = ["not set", "Slow", "Med", "Fast"]
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
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            playerLabel.text = nodeData[row]
            self.tower?.attack.setSpeedLevel(row)
            moneySpent = (row-previousSelection) * 100
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
        previousSelection = tower.attack.speedLevel
    }
    
}

class DeffenseSetRange: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var tower: TowerBase?
    var moneySpent = 0
    var previousSelection : Int = 0
    var nodeData = ["not set", "close", "med", "Far"]
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
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            playerLabel.text = nodeData[row]
            tower?.defense.setRangeLevel(row)
            moneySpent = (row-previousSelection) * 100
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
        previousSelection = tower.defense.rangeLevel
   
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
    var previousSelection : Int = 0
    var nodeData = ["nont", "low", "med", "high"]
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
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
        playerLabel.text = nodeData[row]
        tower?.defense.setAmountLevel(row)
        moneySpent = (row-previousSelection) * 100
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
        previousSelection = tower.defense.amountLevel
        
    }
    
}

class AttackSetStrategy: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    var moneySpent = 0
    var previousSelection : Int = 0
    var tower: TowerBase?
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var X : CGFloat = 0
    var Y : CGFloat = 0
    var nodeData = ["None", "Cannon", "Pulse"]
    override init(x: CGFloat, y: CGFloat)
    {
        X = x
        Y = y
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Attack Type"
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
        switch(row) {
        case 0:
            if (previousSelection != 0) {
                tower?.attack = TowerAttackStrat()
                tower?.attack.parent = tower
                tower?.attackSelection = 0
            }
            break
        case 1:
            if (previousSelection != 1) {
                tower?.attack = TowerAttackBasic()
                tower?.attack.parent = tower
                tower?.attackSelection = 1
            }
            //initialize the nodes of the chain
            let setRangeNode = AttackSetRange(x: X, y: Y)
            let setDamageNode = AttackSetDamage(x: X, y: Y)
            let fireDeleyNode = SetFireDelay(x: X, y: Y)
            let setSpeed = SetSpeed(x: X, y: Y)
            
            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setDamageNode)
            setDamageNode.setNextNode(fireDeleyNode)
            fireDeleyNode.setNextNode(setSpeed)
            
            break
        case 2:
            if (previousSelection != 2) {
                tower?.attack = TowerAttackPulse()
                tower?.attack.parent = tower
                tower?.attackSelection = 2
            }
            //initialize the nodes of the chain
            let setRangeNode = AttackSetRange(x: X, y: Y)
            let setDamageNode = AttackSetDamage(x: X, y: Y)
            let fireDeleyNode = SetFireDelay(x: X, y: Y)
            
            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setDamageNode)
            setDamageNode.setNextNode(fireDeleyNode)
            
            break
        default:
            print("Invalid Row")
            break
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
        previousSelection = tower.attackSelection
        
    }
    
}

class DefenseSetStrategy: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    var moneySpent = 0
    var previousSelection : Int = 0
    var tower: TowerBase?
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var X : CGFloat = 0
    var Y : CGFloat = 0
    var nodeData = ["None", "Heal", "Slag"]
    override init(x: CGFloat, y: CGFloat)
    {
        X = x
        Y = y
        super.init(x: x, y: y)
        self.nextNode = nil
        self.mainLabel.text = "Set Defense Type"
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
        switch(row) {
        case 0:
            if (previousSelection != 0) {
                tower?.defense = TowerDefenseStrat()
                tower?.defense.parent = tower
                tower?.defenseSelection = 0
            }
            break
        case 1:
            if (previousSelection != 1) {
                tower?.defense = TowerDefenseHeal()
                tower?.defense.parent = tower
                tower?.defenseSelection = 1
            }
            //initialize the nodes of the chain
            let setRangeNode = DeffenseSetRange(x: X, y: Y)
            let setAmountNode = DeffenseSetAmount(x: X, y: Y)

            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setAmountNode)
            
            break
        case 2:
            if (previousSelection != 2) {
                tower?.defense = TowerDefenseSlag()
                tower?.defense.parent = tower
                tower?.defenseSelection = 2
            }
            //initialize the nodes of the chain
            let setRangeNode = DeffenseSetRange(x: X, y: Y)
            let setAmountNode = DeffenseSetAmount(x: X, y: Y)
            
            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setAmountNode)
            
            break
        default:
            print("Invalid Row")
            break
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
        previousSelection = tower.defenseSelection
        
    }
    
}

class StartNode: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    //each node needs a towerBase variable because we need access to it outside of the upgrade function
    var tower: TowerBase?
    var selection : Int = 0
    var X : CGFloat = 0
    var Y : CGFloat = 0
    //this array represents the datasource for the UIPickerView
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    var nodeData = ["Attack", "Defense"] // TODO: ADD SELL OPTION
    init(x: CGFloat, y: CGFloat, tower: TowerBase)
    {
        X = x
        Y = y
        super.init(x: x, y: y)
        self.nextNode = nil
        self.tower = tower
        mainLabel.text = "Menu"
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self

        
    }
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
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
        selection = row
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    func setNextNode(node: UpgradeNode)
    {
        self.nextNode = node
    }
    //fucntion to begin the upgrade request down the chain
    func startUpgradeChain()
    {
        switch(selection) {
        case 0:
            let attackNode = AttackSetStrategy(x: X, y: Y)
            self.setNextNode(attackNode)
            break
        case 1:
            let defenseNode = DefenseSetStrategy(x: X, y: Y)
            self.setNextNode(defenseNode)
            break
        default:
            print("Invalid Row")
            break
        }
        
        if self.nextNode != nil
        {
            //this is kinda goofy cus this first node calls these two methods diffrently than the onther nodes that follow this one.
            upgrade(self.tower!)
        }
        else{ }
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