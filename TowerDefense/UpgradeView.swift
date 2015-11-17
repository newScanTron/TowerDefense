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
    var b = UIButton(frame: CGRectMake(0,0, 200,40))
    var c = UIButton(frame: CGRectMake(0,160, 200,40))
    
    /*/hopoing to have the same set up for each node as far
    as what lables and inputs they will need. right now im thinking 
    lables sellector wheel and buttons */
    var rectOne = CGRectMake(0,0,200, 40)
    var rectTwo = CGRectMake(0,0,200, 40)
    var rectThree = CGRectMake(0,75,200, 60)


    var mainLabel: UILabel
    var playerLabel: UILabel
    var upgradeSelection: UIPickerView
    
    //this is the array that each node will use to pose their question
    
    required init?(coder aDecoder: (NSCoder!)) {
        mainLabel = UILabel(frame: rectTwo)
        playerLabel = UILabel(frame: rectThree)
        upgradeSelection = UIPickerView(frame: rectThree)
        upgradeSelection.backgroundColor = SKColor.greenColor()
        super.init(coder: aDecoder)
    }
   
    init(x: CGFloat, y: CGFloat)
    {
        
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectTwo)
        upgradeSelection = UIPickerView(frame: rectThree)
        upgradeSelection.backgroundColor = SKColor.greenColor()

        super.init(frame:CGRectMake(x, y, 200, 200))
        b.setTitle("yeah", forState: UIControlState.Normal)
        c.setTitle("Canel", forState: UIControlState.Normal)
        mainLabel.text = "This is Question about what to upgrade?"
        mainLabel.sizeToFit()

        
        playerLabel.text = "Player: "
        self.backgroundColor =  UIColor.yellowColor()
        b.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        
        c.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        c.addTarget(self, action: "CheckLabel", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(b)
        self.addSubview(c)
        self.addSubview(mainLabel)
        self.addSubview(playerLabel)
        self.addSubview(upgradeSelection)

    }
    func setLabels()
    {
        
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
    
        if b.titleLabel?.text == "nope"
        {
            b.setTitle("yeah", forState: UIControlState.Normal)
        }
        else
        {
            b.setTitle("nope", forState: UIControlState.Normal)
        }
        
    }
    
    
}