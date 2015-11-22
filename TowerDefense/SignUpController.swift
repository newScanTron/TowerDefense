//
//  SignUpController.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/21/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class SignUpController: UIViewController
{
    //IB outlets and one action to gather the user input from the SignUp view
    @IBOutlet weak var PasswordTwoText: UITextField!
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBAction func CreateUserAct(sender: AnyObject) {
        checkPasswords()
    
        
    }
//
    var userName = ""
    var password = ""
    
    
    //function to check if passwords match
    func checkPasswords()
    {
        if PasswordText.text == PasswordTwoText.text
        {
            print("passwords match")
        }
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
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}