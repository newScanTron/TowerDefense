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
    
    
    
   
    init()
    {
        super.init(frame: CGRectMake(0, 0, 200, 200))
        b.setTitle("yeah", forState: UIControlState.Normal)
        b.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        b.addTarget(self, action: "CheckLabel", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(b)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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