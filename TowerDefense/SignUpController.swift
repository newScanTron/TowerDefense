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
    //1
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
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
            appDelegate.saveUser(UserNameText.text!, passwd: PasswordText.text!)
            performSegueWithIdentifier("backToLogin", sender: nil)
        }
    }

    
}