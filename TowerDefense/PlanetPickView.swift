//
//  PlanetPickView.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/20/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SpriteKit

class PlanetPickView: UIViewController
{
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    //UIViewController function to do any setup that is requried for the game.
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.planetPickScene = PlanetPickScene(fileNamed: "PlanetPickScene")!
        
        let skView = self.view as! SKView
        
        
        
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        appDelegate.planetPickScene!.scaleMode = .AspectFill
        PlanetPickScene.scene = appDelegate.planetPickScene
        
        appDelegate.planetPickScene!.viewController = self
        skView.presentScene(appDelegate.planetPickScene)
    }
    func goToScene()
    {
        appDelegate.sideScrollScene = SideScrolScene(fileNamed: "SideScrollScene")!
    }
    
}