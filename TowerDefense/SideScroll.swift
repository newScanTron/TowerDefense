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
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    //UIViewController function to do any setup that is requried for the game.
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.sideScrollScene = SideScrolScene(fileNamed: "SideScrollScene")!

        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        swipeLeft.numberOfTouchesRequired = 2
        view.addGestureRecognizer(swipeLeft)
        //this block adds a call to the function swiped right when the user swipes right with 2 fingers
//        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
//        swipeRight.numberOfTouchesRequired = 2
//        swipeRight.direction = .Right
//        view.addGestureRecognizer(swipeRight)
        
      
        let skView = self.view as! SKView
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        appDelegate.sideScrollScene!.scaleMode = .AspectFill
        SideScrolScene.scene = appDelegate.sideScrollScene
        
        appDelegate.sideScrollScene!.viewController = self
        skView.presentScene(appDelegate.sideScrollScene)
          appDelegate.sideScrollScene!.paused = false
    }
    override func viewDidDisappear(animated: Bool) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate!.updateUser()
        SideScrolScene.scene?.removeAllChildren()
        SideScrolScene.items = [Item]()
       print("we left the side scroll scene")
        appDelegate!.sideScrollScene!.paused = true

    }
    func swipedLeft(sender:UISwipeGestureRecognizer){
        performSegueWithIdentifier("GoToTowerDefense", sender: nil)
    }
}