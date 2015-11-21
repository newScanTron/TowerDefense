//
//  GameViewController.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/27/15.
//  Copyright (c) 2015 Chris Murphy. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class GameViewController: UIViewController {
    
    //a object to represent the usrrent player
    var player = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            

            GameScene.scene = scene

            
            let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
            swipeLeft.direction = .Left
            view.addGestureRecognizer(swipeLeft)
            

            
            skView.presentScene(scene)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        
    }
    func swipedLeft(sender:UISwipeGestureRecognizer){
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
    func saveUser(name: String, passwd: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let user = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        user.setValue(name, forKey: "userName")
        user.setValue(passwd, forKey: "pswd")
        
        //4
        do {
            try managedContext.save()
            //5
            player.setUser(name, psswd: passwd)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
