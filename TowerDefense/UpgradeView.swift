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

class UpgradeView: UIView {
    var b = UIButton(frame: CGRectMake(25,160, 50,40))
    var c = UIButton(frame: CGRectMake(125,160, 50,40))
    
    /*/hopoing to have the same set up for each node as far
    as what lables and inputs they will need. right now im thinking 
    lables sellector wheel and buttons */
    var rectOne = CGRectMake(10, 10 ,200, 60)
    var rectPlayerLbl = CGRectMake(10,20,200, 60)
    var rectThree = CGRectMake(0,75,200, 65)


    var mainLabel: UILabel
    var playerLabel: UILabel
    var upgradeSelection: UIPickerView
    
    //this is the array that each node will use to pose their question
    
    required init?(coder aDecoder: (NSCoder!)) {
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectPlayerLbl)
        upgradeSelection = UIPickerView(frame: rectThree)
        upgradeSelection.backgroundColor = SKColor.greenColor()
        super.init(coder: aDecoder)
    }
   
    init(x: CGFloat, y: CGFloat)
    {
        
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectPlayerLbl)
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
        self.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        b.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        c.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        c.addTarget(self, action: "CheckLabel", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(b)
        self.addSubview(c)
        self.addSubview(mainLabel)
        self.addSubview(playerLabel)
        self.addSubview(upgradeSelection)

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
    func CheckLabel()
    {
       self.removeFromSuperview()
    }
   
    //now that i understand the chain of repsonsiblity that is the UITuoch Objects
    //this is easy to do.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    

        
    }
    
    
  
    
}