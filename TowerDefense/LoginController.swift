//
//  LoginController.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/20/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LoginController
{
    var user: User
    
    init()
    {
        user = User()
    }
    @IBAction func newUser(sender: AnyObject) {
        
        
      
    }
    
    func saveName(name: String, passwd: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(name, forKey: "userName")
        person.setValue(passwd, forKey: "passwd")
        
        //4
        do {
            try managedContext.save()
            print(person.valueForKey("userName"))
            //5
            user = User(userName: name, pswd: passwd)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}