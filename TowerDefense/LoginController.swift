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

class LoginController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
    
{
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var passText: UITextField!
    @IBAction func playButtonAct(sender: AnyObject) {
        checkUser()
    }
    @IBOutlet weak var UserPicker: UIPickerView!
    @IBOutlet weak var userNameLbl: UILabel!
    var user = User()
    var people = [User]()
    var gameSt = [GameState]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UserPicker.dataSource = self
        UserPicker.delegate = self
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            if results.count > 0
            {
                for result: AnyObject in results
                {
                    
                   // print(result)
                    if let u = result.valueForKey("userName") as? String
                    {
                        if let p = result.valueForKey("psswd") as? String, let xp = result.valueForKey("xp") as? Int, let gold = result.valueForKey("gold") as? Int
                        {
                            user = User(userName: u, pswd: p, xp: xp, gold: gold)
                            
                            people.append(user)
                            
//                            if let addresses = result.valueForKey("hasGameState")
//                            {
//                                
//                                if addresses.count > 0
//                                {
//                               
//                                
//                                
////                                let gold = addresses.valueForKey("gold") as? String
////                                let  xp = result.valueForKey("hasGameState.xp") as? String
////                                print("thtp", xp)
////                                gameSt.append(GameState(user: user, xp: xp!, gold: gold!))
//                                }
//                                
//                            }//some weak debug loopoing
                        }
                        else
                        {
                            print("could not add user and create")
                            
                        }
                    }
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func checkUser() {
        
        if appDelegate.user.pswd == passText.text!
        {
            
        performSegueWithIdentifier("playGame", sender: nil)
        }
        else
        {
        print("not loged it")
        }
    }
    
    //functions conforming to the UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row].userName
    }
    //function
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userNameLbl.text = people[row].userName
        appDelegate.user = people[row]
        //appDelegate.gameState = gameSt[row]
        
        
    }
    
    
}