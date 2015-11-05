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
    var c = UIButton(frame: CGRectMake(0,10, 200,40))
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
   
    init(x: CGFloat, y: CGFloat)
    {
        super.init(frame: CGRectMake(x, y, 200, 200))
        b.setTitle("yeah", forState: UIControlState.Normal)
        c.setTitle("Canel", forState: UIControlState.Normal)
        self.backgroundColor =  UIColor.yellowColor()
        b.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        c.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        c.addTarget(self, action: "CheckLabel", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(b)
        self.addSubview(c)

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