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
    
    var nextNode : UpgradeNode?
    var tower : TowerBase?
    var moneySpent = 0
    var previousSelection : Int = 0
    var selection : Int = 0
    var nodeData = ["Option1", "Option2", "Option3", "Option4"]
    var mx : CGFloat = 0
    var my : CGFloat = 0
    
    var b = UIButton(frame: CGRectMake(25,160, 50,40))
    var c = UIButton(frame: CGRectMake(125,160, 50,40))
    
    /*/hopoing to have the same set up for each node as far
    as what lables and inputs they will need. right now im thinking 
    lables sellector wheel and buttons */
    var rectOne = CGRectMake(10, 10 ,200, 60)
    var rectPlayerLbl = CGRectMake(10,20,200, 60)
    var rectCost = CGRectMake(10,35,200, 60)
    var rectThree = CGRectMake(0,75,200, 65)


    var mainLabel: UILabel
    var playerLabel: UILabel
    var costLabel: UILabel
    var upgradeSelection: UIPickerView
    
    //this is the array that each node will use to pose their question
    
    required init?(coder aDecoder: (NSCoder!)) {
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectPlayerLbl)
        costLabel = UILabel(frame: rectCost)
        upgradeSelection = UIPickerView(frame: rectThree)
        upgradeSelection.backgroundColor = SKColor.greenColor()
        super.init(coder: aDecoder)
    }
   
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
        mainLabel.text = "This is Question about what to upgrade?"
        mainLabel.font = UIFont(name: "Square", size: 23.0)
        mainLabel.sizeToFit()

        
        playerLabel.text = "Choose An Option."
        playerLabel.font = UIFont(name: "Square", size: 18.0)
        costLabel.text = "Gold: "
        costLabel.font = UIFont(name: "Square", size: 18.0)
        self.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        b.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        c.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
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
    
    func setNextNode(node: UpgradeNode)
    {
        nextNode = node
    }
    
    func upgrade(tower: TowerBase)
    {
        
        GameScene.scene?.view?.addSubview(self)
        
        self.tower = tower
        
        upgradeSelection.selectRow(previousSelection, inComponent: 0, animated: false)
        selection = previousSelection
        
        
    }
    func donePressed() {
        nextNode = nil
        startUpgradeChain()
    }
    
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

    
    func setLabels() -> (first: CGFloat, second: CGFloat)
    {
        return (self.frame.midX, self.frame.midY)
    }
    func SetViewLocation(x: CGFloat, y: CGFloat)
    {
        self.frame = CGRectMake(x, y, 200, 400)
    }
    
    func GetView() ->UIView
    {
        return self
    }
    //pressing the label will currently remove the UpgradeView
    func removeSelf()
    {
       self.removeFromSuperview()
    }
   
    //now that i understand the chain of repsonsiblity that is the UITuoch Objects
    //this is easy to do.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    

        
    }
    
    
  
    
}