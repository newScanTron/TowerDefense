//
//  AttackNode.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
//set attack range node.  Each of these noodes extend UpgradeView which is a custom UIView class i have created to give each of these noedes a uniform interface.  Upgrade node
//is the protocol that represents the Processing elements structure that each of these nodes are the concrete implemntation of.  UIPickerViewDelegate and UIPickerViewDataSource are


func setPicker(inout upgradeSelection: UIPickerView) -> Int
{
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    if appDelegate.user.gold >= 100
    {
        upgradeSelection.selectRow(0, inComponent: 0, animated: false)
    }
    if appDelegate.user.gold >= 200
    {
        upgradeSelection.selectRow(1, inComponent: 0, animated: false)
    }
    if appDelegate.user.gold >= 300
    {
        upgradeSelection.selectRow(2, inComponent: 0, animated: false)
    }
    if appDelegate.user.gold >= 400
    {
        upgradeSelection.selectRow(3, inComponent: 0, animated: false)
    }
    return upgradeSelection.selectedRowInComponent(0)
}


class AttackSetHoming: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    
    var circle : SKShapeNode = SKShapeNode()
    var validColor : SKColor = SKColor(red: 0.0, green: 0.9, blue: 0.5, alpha: 0.2)
    var invalidColor : SKColor = SKColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2)
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    var costs = [0,300]
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        
        
        
        //changing the picker color to something more in line with what is being choosen all just to make it change so more than the text changes.
        upgradeSelection.backgroundColor = UIColor(red: 0.0, green: 0.65, blue: 0.75, alpha: 0.8)
        
        self.mainLabel.text = "Set Homing Level"
        nodeData = ["OFF", "ON"]
        
        
        
    }
    
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        
        if appDelegate.user.gold >= (costs[row]-costs[previousSelection])
        {
            selection = row
            playerLabel.text = nodeData[row]
            moneySpent = (costs[row]-costs[previousSelection])
            costLabel.text = "Gold: " + String(moneySpent)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
        }
        
        
    }
    
    
    
    override func startUpgradeChain()
        
    {
        (self.tower?.attack as! TowerAttackBasic).setHomingLevel(selection)
        circle.removeFromParent()
        
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        
        
        previousSelection = (tower.attack as! TowerAttackBasic).homingLevel
        super.upgrade(tower)
        
        
        
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}

class AttackSetExplosion: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    
    var circle : SKShapeNode = SKShapeNode()
    var validColor : SKColor = SKColor(red: 0.0, green: 0.9, blue: 0.5, alpha: 0.2)
    var invalidColor : SKColor = SKColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2)
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    var costs = [0,500,750,1000]
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        
        
        
        //changing the picker color to something more in line with what is being choosen all just to make it change so more than the text changes.
        upgradeSelection.backgroundColor = UIColor(red: 0.0, green: 0.65, blue: 0.75, alpha: 0.8)
        
        self.mainLabel.text = "Set Explosion"
        nodeData = ["OFF", "WEAK", "MEDIUM","STRONG"]
        
        
        
    }
    
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    
        
        
        if appDelegate.user.gold >= (costs[row]-costs[previousSelection])
        {
            selection = row
            playerLabel.text = nodeData[row]
            moneySpent = (costs[row]-costs[previousSelection])
            costLabel.text = "Gold: " + String(moneySpent)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
        }
        
        
        
    }
    
    
    
    override func startUpgradeChain()
        
    {
        (self.tower!.attack as? TowerAttackBasic)!.setExplosionLevel(selection)
        circle.removeFromParent()
        
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        
        
        previousSelection = (tower.attack as! TowerAttackBasic).expLevel
        super.upgrade(tower)
        
        selection = setPicker(&upgradeSelection)
        
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}


class AttackSetRange: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    
    var circle : SKShapeNode = SKShapeNode()
    var validColor : SKColor = SKColor(red: 0.0, green: 0.9, blue: 0.5, alpha: 0.2)
    var invalidColor : SKColor = SKColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2)
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        //changing the picker color to something more in line with what is being choosen all just to make it change so more than the text changes.
        upgradeSelection.backgroundColor = UIColor(red: 0.0, green: 0.65, blue: 0.75, alpha: 0.8)
        
        self.mainLabel.text = "Set Range Amount"
        nodeData = ["CLOSE", "MEDIUM", "FAR", "SNIPER"]
        
        
    }
    
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            selection = row
            playerLabel.text = nodeData[row]
            moneySpent = (row-previousSelection) * 100
            costLabel.text = "Gold: " + String(moneySpent)
            
            tower?.attack.setRangeLevel(selection)
            visualizeCircle(&circle, radius: (tower?.attack.range)!, color: validColor)
            tower?.attack.setRangeLevel(previousSelection)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
            tower?.attack.setRangeLevel(selection)
            visualizeCircle(&circle, radius: (tower?.attack.range)!, color: invalidColor)
            tower?.attack.setRangeLevel(previousSelection)
        }
        
        
        
    }
    
    
    
    override func startUpgradeChain()
        
    {
        self.tower?.attack.setRangeLevel(selection)
        circle.removeFromParent()
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        
        
        previousSelection = tower.attack.rangeLevel
        super.upgrade(tower)
        selection = setPicker(&upgradeSelection)
        
        
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}



//set Attack damage
class AttackSetDamage: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        self.mainLabel.text = "Set Damage Amount"
        nodeData = ["LOW", "MED", "HIGH", "SLAUGHTER"]
        
      
    }
    
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            selection = row
            playerLabel.text = nodeData[row]
            moneySpent = (row-previousSelection) * 100
            costLabel.text = "Gold: " + String(moneySpent)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
        }
    }
    
    
    override func startUpgradeChain()
    {
        
        self.tower?.attack.setDamageLevel(selection)
        
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        
        
        previousSelection = tower.attack.damageLevel
        super.upgrade(tower)
       selection = setPicker(&upgradeSelection)
        
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}
//set Fire delay
class SetFireDelay: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        nodeData = ["SLOW", "MEDIUM", "FAST","LUDACRIS"]
        self.mainLabel.text = "Set Fire Rate"
        
        
        
    }
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if appDelegate.user.gold >= (row-previousSelection) * 100
            
        {
            selection = row
            playerLabel.text = nodeData[row]
            moneySpent = (row-previousSelection) * 100
            costLabel.text = "Gold: " + String(moneySpent)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
        }
    }
    
    
    override func startUpgradeChain()
    {
        
        tower?.attack.setFireDelayLevel(selection)
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
        
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        
        
        previousSelection = tower.attack.fireDelayLevel
        super.upgrade(tower)
       selection = setPicker(&upgradeSelection)
        
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}
//set the speed of the the bullet?
class SetSpeed: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        nodeData = ["SLOW", "MEDIUM", "FAST", "BLAZING"]
        self.mainLabel.text = "Set Bullet Speed"
        
        
        upgradeSelection.backgroundColor = UIColor(red: 0.7, green: 0.3, blue: 0.7, alpha: 0.8)
        
    }
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    //intersting fucntion to how the tower gets affected.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            selection = row
            playerLabel.text = nodeData[row]
            
            
            moneySpent = (row-previousSelection) * 100
            costLabel.text = "Gold: " + String(moneySpent)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
        }
    }
    
    
    override func startUpgradeChain()
    {
        
        tower?.attack.setSpeedLevel(selection)
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        
        super.startUpgradeChain()
        
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        previousSelection = tower.attack.speedLevel
        super.upgrade(tower)
       selection = setPicker(&upgradeSelection)
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}

class DefenseSetRange: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    var circle : SKShapeNode = SKShapeNode()
    var validColor : SKColor = SKColor(red: 0.0, green: 0.9, blue: 0.5, alpha: 0.2)
    var invalidColor : SKColor = SKColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2)
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        nodeData = ["CLOSE", "MEDIUM", "FAR", "FARTHER"]
        self.mainLabel.text = "Defense Range"
        
    }
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            selection  = row
            playerLabel.text = nodeData[row]
            
            moneySpent = (row-previousSelection) * 100
            costLabel.text = "Gold: " + String(moneySpent)
            tower?.defense.setRangeLevel(selection)
            visualizeCircle(&circle, radius: (tower?.defense.range)!, color: validColor)
            tower?.defense.setRangeLevel(previousSelection)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
            tower?.defense.setRangeLevel(selection)
            visualizeCircle(&circle, radius: (tower?.defense.range)!, color: invalidColor)
            tower?.defense.setRangeLevel(previousSelection)
        }
    }
    
    override func startUpgradeChain()
    {
        
        
        tower?.defense.setRangeLevel(selection)
        circle.removeFromParent()
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
        
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        previousSelection = tower.defense.rangeLevel
        super.upgrade(tower)
      selection = setPicker(&upgradeSelection)
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
    
}
//Set amout of deffenset
class DefenseSetAmount: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        nodeData = ["LOW", "MEDIUM", "HIGH", "ULTRA"]
        self.mainLabel.text = "Defense Set Amount"
        
        
        
    }
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.user.gold >= (row-previousSelection) * 100
        {
            selection = row
            playerLabel.text = nodeData[row]
            
            moneySpent = (row-previousSelection) * 100
            costLabel.text = "Gold: " + String(moneySpent)
            
        }
        else
        {
            selection = previousSelection
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
        }
    }
    
    
    override func startUpgradeChain()
    {
        
        
        tower?.defense.setAmountLevel(selection)
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        previousSelection = tower.defense.amountLevel
        super.upgrade(tower)
       selection = setPicker(&upgradeSelection)
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}

class AttackSetStrategy: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    override init(x: CGFloat, y: CGFloat)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        nodeData = ["NONE", "CANNON", "PULSE"]
        self.mainLabel.text = "Set Attack Type"
        mx = x
        my = y
        
        
    }
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = row
    }
    
    
    override func startUpgradeChain()
    {
        switch(selection) {
        case 0:
            // Cancels the chain
            print("ha")
            break
        case 1:
            if (previousSelection != 1) {
                tower?.setAttack(TowerAttackBasic())
                //tower?.attack.parent = tower
                tower?.attackSelection = 1
            }
            //initialize the nodes of the chain
            let setRangeNode = AttackSetRange(x: mx, y: my)
            let setDamageNode = AttackSetDamage(x: mx, y: my)
            let fireDelayNode = SetFireDelay(x: mx, y: my)
            let speedNode = SetSpeed(x: mx, y: my)
            let expNode = AttackSetExplosion(x: mx, y: my)
            let homingNode = AttackSetHoming(x: mx, y: my)
            
            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setDamageNode)
            setDamageNode.setNextNode(fireDelayNode)
            fireDelayNode.setNextNode(speedNode)
            speedNode.setNextNode(expNode)
            expNode.setNextNode(homingNode)
            
            break
        case 2:
            if (previousSelection != 2) {
                tower?.setAttack(TowerAttackPulse())
                //tower?.attack.parent = tower
                tower?.attackSelection = 2
            }
            //initialize the nodes of the chain
            let setRangeNode = AttackSetRange(x: mx, y: my)
            let setDamageNode = AttackSetDamage(x: mx, y: my)
            let fireDelayNode = SetFireDelay(x: mx, y: my)
            
            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setDamageNode)
            setDamageNode.setNextNode(fireDelayNode)
            
            break
        default:
            print("Invalid Row")
            break
        }
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        
        super.startUpgradeChain()
        
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        
        previousSelection = tower.attackSelection
        
        super.upgrade(tower)
        upgradeSelection.selectRow(1, inComponent: 0, animated: false)
        selection = 1
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}

class DefenseSetStrategy: UpgradeView,  UIPickerViewDelegate, UIPickerViewDataSource
{
    
    
    
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    override init(x: CGFloat, y: CGFloat)
    {
        
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        nodeData = ["NONE", "HEAL", "SLAG"]
        self.mainLabel.text = "Set Defense Type"
        mx = x
        my = y
        
    }
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = row
    }
    
    
    override func startUpgradeChain()
    {
        switch(selection) {
        case 0:
            if (previousSelection != 0) {
                tower?.setDefense(TowerDefenseStrat())
                //tower?.defense.parent = tower
                tower?.defenseSelection = 0
            }
            break
        case 1:
            if (previousSelection != 1) {
                tower?.setDefense(TowerDefenseHeal())
                //tower?.defense.parent = tower
                tower?.defenseSelection = 1
            }
            //initialize the nodes of the chain
            let setRangeNode = DefenseSetRange(x: mx, y: my)
            let setAmountNode = DefenseSetAmount(x: mx, y: my)
            
            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setAmountNode)
            
            break
        case 2:
            if (previousSelection != 2) {
                tower?.setDefense(TowerDefenseSlag())
                //tower?.defense.parent = tower
                tower?.defenseSelection = 2
            }
            //initialize the nodes of the chain
            let setRangeNode = DefenseSetRange(x: mx, y: my)
            let setAmountNode = DefenseSetAmount(x: mx, y: my)
            
            //set all the nodes to the seccuessor
            self.setNextNode(setRangeNode)
            setRangeNode.setNextNode(setAmountNode)
            
            break
        default:
            print("Invalid Row")
            break
        }
        
        tower!.value += moneySpent
        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
    }
    
    
    //the method that all nodes will implement in different fashions.
    override func upgrade(tower: TowerBase)
    {
        
        previousSelection = tower.defenseSelection
        super.upgrade(tower)
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}

class StartNode: UpgradeView, UIPickerViewDelegate, UIPickerViewDataSource
{
    //each node needs a towerBase variable because we need access to it outside of the upgrade function
    var costs = [0,0,0,GameScene.scene!.towerBuilder.clipboard.value]
    //this array represents the datasource for the UIPickerView
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    init(x: CGFloat, y: CGFloat, tower: TowerBase)
    {
        super.init(x: x, y: y)
        
        upgradeSelection.dataSource = self
        upgradeSelection.delegate = self
        nodeData = ["ATTACK", "DEFENSE","COPY","PASTE"] // TODO: ADD SELL OPTION
        mainLabel.text = "BUILD"
        mx = x
        my = y
        self.tower = tower
        
        
    }
    
    
    //UIpicker functions
    //functions conforming to the UIPickerView DataSource
    
    //once again this is part of how iOS does stuff and i am using it to effect the jplayer gold and the tower(processing node).
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if appDelegate.user.gold >= costs[row]
        {
            selection = row
            moneySpent = costs[row]
            playerLabel.text = " "
            if (costs[row]) > 0 {
                playerLabel.text = "Cost: " + String(costs[row])
            }
            else {
                playerLabel.text = " "
            }
            
        }
        else
        {
            playerLabel.text = "NOT ENOUGH GOLD"
            upgradeSelection.selectRow(selection, inComponent: 0, animated: true)
        }
    }
    
    override func donePressed() {
        selection = -1
        super.donePressed()
    }
    
    //fucntion to begin the upgrade request down the chain
    override func startUpgradeChain()
    {
        switch(selection) {
        case -1:
            break
        case 0:
            let attackNode = AttackSetStrategy(x: mx, y: my)
            self.setNextNode(attackNode)
            break
        case 1:
            let defenseNode = DefenseSetStrategy(x: mx, y: my)
            self.setNextNode(defenseNode)
            break
        case 2:
            GameScene.scene!.towerBuilder.copyTower(tower!)
            break
        case 3:
            if (GameScene.scene!.towerBuilder.clipboard.value <= appDelegate.user.gold) {
                GameScene.scene!.towerBuilder.pasteTower(&tower!)
                moneySpent = tower!.value
            }
        default:
            print("Invalid Row")
            break
        }

        appDelegate.user.gold -= moneySpent
        appDelegate.updateMyLabel()
        
        super.startUpgradeChain()
        
    }
    
    //the method that all nodes will implement in different fashions. Taking values from the UIPickerView to select the correct array elements.
    override func upgrade(tower: TowerBase)
    {
        
        super.upgrade(tower)
        
        self.nextNode?.upgrade(tower)
        
    }
    
    required init?(coder aDecoder: (NSCoder!)) {super.init(coder: aDecoder)}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {return 1}
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return nodeData.count}
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return nodeData[row]}
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = nodeData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Square", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
}