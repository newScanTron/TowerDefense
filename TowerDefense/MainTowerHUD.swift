//
//  MainTowerHUD.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/25/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MainTowerHUD: UIView {
    
    init(x: CGFloat, y: CGFloat)
    {
        super.init(frame:CGRectMake(20, 20, 666, 200))
        self.backgroundColor = UIColor(red: 200, green: 155, blue: 34, alpha: 0.2)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        self.removeFromSuperview()
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.gameScene?.mainHudIsUP = false
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
}
