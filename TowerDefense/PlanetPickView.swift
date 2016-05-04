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
        appDelegate.gameScene = GameScene(fileNamed:"GameScene")
        appDelegate.gameScene!.viewController = self
        let skView = self.view as! SKView
        
        
        
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = false
        
        /* Set the scale mode to scale to fit the window */
        appDelegate.planetPickScene!.scaleMode = .AspectFill
        PlanetPickScene.scene = appDelegate.planetPickScene
        
        appDelegate.planetPickScene!.viewController = self
        skView.presentScene(appDelegate.planetPickScene)
        appDelegate.planetPickScene?.paused = false
    }
    override func viewDidDisappear(animated: Bool) {
        appDelegate.planetPickScene?.paused = true
    }
    func goToScene()
    {
        appDelegate.sideScrollScene = SideScrolScene(fileNamed: "SideScrollScene")!
    }
    func toSideScroll(){
        performSegueWithIdentifier("gameToSide", sender: nil)
    }
    func goToTowerDefense(){
        performSegueWithIdentifier("GoToSideScroll", sender: nil)
    }
   
}