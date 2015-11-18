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
class AttackSetRange: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    var tower: TowerBase?
    var nodeData = ["Range", "is", "up"]
    init(x: CGFloat, y: CGFloat, tower: TowerBase)
    {
        super.init(x: x, y: y)
        self.nextNode = nil
        self.tower = tower
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
        upgrade(self.tower!)
    }
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        self.tower!.attack.range = 2
        
        self.mainLabel.text = "this is the Set Attach Range Node"
        self.upgradeSelection.dataSource = self
        self.upgradeSelection.delegate = self
      //  GameScene.scene!.view!.addSubview(self)
        
        if self.nextNode != nil
        {
            print("node is not nil")
            self.removeFromSuperview()
            self.nextNode?.upgrade(tower)
            
        }
        else
        {
            
        } 
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
            self.removeFromSuperview()
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        print("we are now in the Attack Damage node")
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
        self.mainLabel.text = " Attach Damage Node"
        self.upgradeSelection.dataSource = self
        self.upgradeSelection.delegate = self
        
       
    }
    
}
//set Fire delay
class SetFireDelay: UpgradeView, UpgradeNode, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextNode: UpgradeNode?
    
    var tower: TowerBase?
    var nodeData = ["fire", "deley", "up"]
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
            self.removeFromSuperview()
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        print("Set Fire Node")
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
        self.mainLabel.text = " Attach Damage Node"
        self.upgradeSelection.dataSource = self
        self.upgradeSelection.delegate = self
        
        
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
            self.removeFromSuperview()
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        print("Set Speed Node")
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
        self.mainLabel.text = " set speed Node"
        self.upgradeSelection.dataSource = self
        self.upgradeSelection.delegate = self
        
        
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
            self.removeFromSuperview()
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        print("Set Fire Node")
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
        self.mainLabel.text = " defense range Node"
        self.upgradeSelection.dataSource = self
        self.upgradeSelection.delegate = self
        
        
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
            self.removeFromSuperview()
            self.nextNode?.upgrade(self.tower!)
        }
        else
        {
            
        }
    }
    
    
    //the method that all nodes will implement in different fashions.
    func upgrade(tower: TowerBase)
    {
        print("Set Fire Node")
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        
        self.mainLabel.text = " defnese set Amount Node"
        self.upgradeSelection.dataSource = self
        self.upgradeSelection.delegate = self
        
        
    }
    
}