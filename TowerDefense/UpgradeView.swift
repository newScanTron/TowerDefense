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
    var b = UIButton(frame: CGRectMake(0,0, 200,10))
    var c = UIButton(frame: CGRectMake(0,10, 200,10))
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
   
    init()
    {
        super.init(frame: CGRectMake(0, 0, 200, 200))
        b.setTitle("yeah", forState: UIControlState.Normal)
        c.setTitle("What", forState: UIControlState.Normal)
        self.backgroundColor =  UIColor.yellowColor()
        b.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        b.addTarget(self, action: "CheckLabel", forControlEvents: UIControlEvents.TouchUpInside)
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
    func CheckLabel()
    {
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