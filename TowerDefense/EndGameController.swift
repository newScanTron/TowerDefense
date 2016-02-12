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
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    @IBOutlet weak var waveLabel: UILabel!
    @IBOutlet weak var tryAgain: UIButton!
    @IBOutlet weak var waveText: UITextField!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    @IBAction func tryAgainButtonAct(sender: AnyObject) {
        
        performSegueWithIdentifier("tryAgain", sender: nil)
    }
    override func viewWillAppear(animated: Bool) {
        waveLabel.text = ("Waves: \(appDelegate!.gameState.wave)")
        goldLabel.text = ("Gold: \(appDelegate!.gameState.gold)")
        xpLabel.text = ("XP: \(appDelegate!.user.xp)")
    }
}