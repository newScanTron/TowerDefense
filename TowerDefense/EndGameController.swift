//
//  EndGameController.swift
//  TowerDefense
//
//  Created by My Macbook Pro on 12/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit

class EndGameController : UIViewController {

    @IBOutlet weak var tryAgain: UIButton!
    @IBAction func tryAgainButtonAct(sender: AnyObject) {
        
        performSegueWithIdentifier("tryAgain", sender: nil)
    }
}