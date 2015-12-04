
//
//  AppDelegate.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/27/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //I had to make init() in both of these classes to to allow be to declare them here before we know what they are going to be.
    var user = User()
    var gameState = GameState()
    var gameScene = GameScene()
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        updateUser()
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
        
    }
//methods to handle CoreData applications
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.plymouthsoftware.core_data" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("UserModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("TowerDefense.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as? NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    //function save user
    
    //saves a user to CoreData
    func saveUser(name: String, passwd: String) {
        
        let managedContext = self.managedObjectContext
        
        //look to see that we infact have a User object
        let entity =  NSEntityDescription.entityForName("User",
            inManagedObjectContext:managedContext)
        let user = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //set the different attributes for the user.
        user.setValue(name, forKey: "userName")
        user.setValue(passwd, forKey: "psswd")
        user.setValue(0, forKey: "xp" )
        user.setValue(1000, forKey: "gold")
        
        // Create Address
//        let gameState = NSEntityDescription.entityForName("GameState", inManagedObjectContext: self.managedObjectContext)
//        let newAddress = NSManagedObject(entity: gameState!, insertIntoManagedObjectContext: self.managedObjectContext)
        
//        // this stuff could be removed it is not working the way i would like it too.
//        newAddress.setValue(1000, forKey: "gold")
//        newAddress.setValue(1, forKey: "xp")
//    
//        let addresses = user.mutableSetValueForKey("hasGameState")
//        addresses.addObject(newAddress)
//        
//        do {
//            try user.managedObjectContext?.save()
//        } catch {
//            let saveError = error as NSError
//            print(saveError)
//        }
        
        //4
        do {
            try managedContext.save()
            //5
            self.user.setUser(name, psswd: passwd)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    //function to update the user when the user wants to save or leave the app abruptly
    func updateUser()
    {
        let managedContext = self.managedObjectContext
        
        //look to see that we infact have a User object
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        //do catch cus its swift and try catch is so easy to assume what it means.
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            //even
            if results.count > 0
            {
                for result: AnyObject in results
                {
                    // print(result)
                    if let u = result.valueForKey("userName") as? String
                    {
                        if self.user.userName == u
                        {
                            result.setValue(self.user.xp, forKey: "xp" )
                            result.setValue(self.user.gold, forKey: "gold")
                            
                            //4
                            do
                            {
                                try managedContext.save()
                            }
                            catch let error as NSError
                            {
                                print("Could not save \(error), \(error.userInfo)")
                            }
                        }
                    }
                    else
                    {
                        print("no user found and could not save")
                    }
                }
            }
        }
        catch let error as NSError {
             print("Could not fetch \(error), \(error.userInfo)")
        }
                
    }
    
    
    //little helper function to update the HUD as it were
    func updateMyLabel()
    {
        self.gameScene.myLabel.text = ("Gold: \(self.user.gold)")
        self.gameScene.xpLabel.text = ("XP: \(self.user.xp)")
    }
}

