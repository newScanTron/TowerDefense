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
        super.init(frame:CGRectMake(x, y, 400, 600))
        self.backgroundColor = UIColor(red: 200, green: 155, blue: 34, alpha: 0.2)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    
}
