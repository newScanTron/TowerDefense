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
    //appDelegate is the where the user data is delt with and this class will need to know about it.
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func pinchAction(sender: AnyObject) {
 
    }
  
    //UIViewController function to do any setup that is requried for the game.
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.gameScene = GameScene(fileNamed:"GameScene")
        // Configure the view.
        let skView = self.view as! SKView
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        /* Set the scale mode to scale to fit the window */
        appDelegate.gameScene!.scaleMode = .AspectFill
        GameScene.scene = appDelegate.gameScene
        //this block adds a call to the function swiped left when the user swipes left with 2 fingers
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        swipeLeft.numberOfTouchesRequired = 2
        view.addGestureRecognizer(swipeLeft)
        //this block adds a call to the function swiped right when the user swipes right with 2 fingers
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.numberOfTouchesRequired = 2
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        appDelegate.gameScene!.viewController = self
        skView.presentScene(appDelegate.gameScene)
    }
    //this method is called when this view is no longer in view e.g. when swiped right and a new user logs in
    override func viewDidDisappear(animated: Bool) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate!.updateUser()
        appDelegate!.gameScene!.scene?.removeAllChildren()
        
        appDelegate!.gameScene!.towers = [TowerBase]()
        appDelegate!.gameScene!.enemies = [EnemyBase]()
    }
    //calls the segue that takes the use to the game over scene
    func gameOver(){
        performSegueWithIdentifier("toEndGame", sender: nil)
    }
    func toPlanetPicker(){
        performSegueWithIdentifier("toPlanetPicker", sender: nil)
    }
    func toSideScroll(){
        performSegueWithIdentifier("gameToSide", sender: nil)
    }
    //calls the segue to side scroll game scene
    //func sideScroll(){
    //    performSegueWithIdentifier(<#T##identifier: String##String#>, sender: <#T##AnyObject?#>)
    //}
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
        performSegueWithIdentifier("backToLogin", sender: nil)
    }
    
    //iOS framework functions that allow the rotation of the iOS device and other things that are automaticly added when the project was created.
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
}
