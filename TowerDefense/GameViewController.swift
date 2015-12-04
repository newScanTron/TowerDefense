//
//  GameViewController.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/27/
//  Copyright (c) 2015 Chris Murphy. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class GameViewController: UIViewController {
    //1
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    //a object to represent the usrrent player
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      appDelegate.gameScene = GameScene(fileNamed:"GameScene")!
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            appDelegate.gameScene.scaleMode = .AspectFill
            

            GameScene.scene = appDelegate.gameScene

            
            let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
            swipeLeft.direction = .Left
            swipeLeft.numberOfTouchesRequired = 2
            view.addGestureRecognizer(swipeLeft)
            
            let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
            swipeRight.numberOfTouchesRequired = 2
            swipeRight.direction = .Right
            view.addGestureRecognizer(swipeRight)
            

            
            skView.presentScene(appDelegate.gameScene)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        appDelegate.gameScene.scene?.removeAllChildren()
        GameScene.towers = [TowerBase]()
        GameScene.enemies = [EnemyBase]()
    }
    //two methods to be the action performed when swipe actions call them
    func swipedLeft(sender:UISwipeGestureRecognizer){
        if GameScene.scene!.view!.paused == false
        {
            GameScene.scene!.view!.paused = true
        }
        else
        {
            GameScene.scene!.view!.paused = false
        }
        
    }
    func swipedRight(sender:UISwipeGestureRecognizer) {
       
        //appDelegate.gameScene.scene?.removeFromParent()
        performSegueWithIdentifier("backToLogin", sender: nil)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
   //saves a user to CoreData
}
