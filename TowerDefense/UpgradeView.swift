//
//  UpgradeView.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/2/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class UpgradeView: UIView, UpgradeNode {
    //all the attibutes that all the upgrade nodes will need to display while gathering user input about how they want to upgade towers.
    var nextNode : UpgradeNode?
    var tower : TowerBase?
    var moneySpent = 0
    var previousSelection : Int = 0
    var selection : Int = 0
    //this is the array that each node will use to pose their question and fill the role of the data source of the UIPickerDataDelegate.
    var nodeData = ["Option1", "Option2", "Option3", "Option4"]
    var mx : CGFloat = 0
    var my : CGFloat = 0
    var b = UIButton(frame: CGRectMake(25,160, 50,40))
    var c = UIButton(frame: CGRectMake(125,160, 50,40))
    var rectOne = CGRectMake(10, 10 ,200, 60)
    var rectPlayerLbl = CGRectMake(10,20,200, 60)
    var rectCost = CGRectMake(10,35,200, 60)
    var rectThree = CGRectMake(0,75,200, 65)
    var mainLabel: UILabel
    var playerLabel: UILabel
    var costLabel: UILabel
    var upgradeSelection: UIPickerView
    
 //this requried init never really gets called, its requried by the framework and only really differs from the init bellow it with  super.init(coder: aDecoder) call.
    required init?(coder aDecoder: (NSCoder!)) {
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectPlayerLbl)
        costLabel = UILabel(frame: rectCost)
        upgradeSelection = UIPickerView(frame: rectThree)
        upgradeSelection.backgroundColor = SKColor.greenColor()
        super.init(coder: aDecoder)
    }
   //all the set up requried to place and display all the UI elements in the upgraade view appropriatly.  Place holder data in place for all the elements that wil be concretly implemented in the nodes that extend this class.
    init(x: CGFloat, y: CGFloat)
    {
        
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectPlayerLbl)
        costLabel = UILabel(frame: rectCost)
        upgradeSelection = UIPickerView(frame: rectThree)
        upgradeSelection.backgroundColor = UIColor(red: 0.0, green: 0.9, blue: 0.5, alpha: 0.8)
        super.init(frame:CGRectMake(x, y, 200, 200))
        b.setTitle("Next", forState: UIControlState.Normal)
        b.titleLabel!.font = UIFont(name: "Square", size: 23.0)
        c.setTitle("Done", forState: UIControlState.Normal)
        c.titleLabel!.font = UIFont(name: "Square", size: 23.0)
        b.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        c.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        mainLabel.text = "This is Question about what to upgrade?"
        mainLabel.font = UIFont(name: "Square", size: 23.0)
        mainLabel.sizeToFit()
        playerLabel.text = "Choose An Option."
        playerLabel.font = UIFont(name: "Square", size: 18.0)
        costLabel.text = "Gold: "
        costLabel.font = UIFont(name: "Square", size: 18.0)
        self.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        c.addTarget(self, action: "removeSelf", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(b)
        self.addSubview(c)
        self.addSubview(mainLabel)
        self.addSubview(playerLabel)
        self.addSubview(costLabel)
        self.addSubview(upgradeSelection)
        self.nextNode = nil
        b.addTarget(self, action: "startUpgradeChain", forControlEvents:  UIControlEvents.TouchUpInside)
        c.addTarget(self, action: "donePressed", forControlEvents:  UIControlEvents.TouchUpInside)

    }
    //as the function name implies this func sets the nextNode para to the node what will next be displayed.
    func setNextNode(node: UpgradeNode)
    {
        nextNode = node
    }
    //the upgrade funtion is the first fuction called when
    func upgrade(tower: TowerBase)
    {
        GameScene.scene?.view?.addSubview(self)
        self.tower = tower
        upgradeSelection.selectRow(previousSelection, inComponent: 0, animated: false)
        selection = previousSelection
    }
    //
    func donePressed() {
        self.removeSelf()
    }
    //this method is used by the various nodes to display a circle that shows how large the area of effect will be whhile the various options are contemplated by the UpgradeView.
    func visualizeCircle(inout circle: SKShapeNode, radius: CGFloat, color: SKColor) {
        
        circle.removeFromParent()
        circle = SKShapeNode(circleOfRadius: radius)
        circle.position = tower!.sprite.position
        circle.lineWidth = 1.0
        circle.glowWidth = 0.5
        circle.fillColor = color
        circle.zPosition = ZPosition.tower-1
        circle.blendMode = SKBlendMode.Screen
        GameScene.scene!.addChild(circle)
    }
    //this funciton was originaly only in the start node and because Xcode will not yet automaticly refactor swift code its is still named start node. really it is the function that calles the next node and removes the current node from the scene.
    func startUpgradeChain()
    {
        if self.nextNode != nil
        {
            self.nextNode?.upgrade(self.tower!)
        }
        self.removeSelf()
    }
    //this function simple sets the views frame to the specified location and sets it to be a square of 200 * 200
    func SetViewLocation(x: CGFloat, y: CGFloat)
    {
        self.frame = CGRectMake(x, y, 200, 400)
    }
    func GetView() ->UIView
    {
        return self
    }
    //incase we need to do more processing when we remove these nodes this is incapsulated in a function call.
    func removeSelf()
    {
       self.removeFromSuperview()
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
      
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
}