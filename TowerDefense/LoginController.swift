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
    
    
    @IBOutlet weak var userNameLbl: UILabel!
    var user = User()
    var people = [NSManagedObject]()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
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
        return people
    }
    //function
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userNameLbl.text = people[row].valueForKey("userName")
    }

    
}