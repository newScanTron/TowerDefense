//
//  SideScroll.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/20/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SpriteKit

class SideScroll: UIViewController
{
    //UIViewController function to do any setup that is requried for the game.
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        let myScene = GameScene(size: skView.frame.size)
    }
}