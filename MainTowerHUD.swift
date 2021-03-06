//
//  MainTowerHUD.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/25/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import CoreData

class MainTowerHUD: UIView {
    var b = UIButton(frame: CGRectMake(25,120, 50,40))
    var c = UIButton(frame: CGRectMake(125,120, 50,40))
    var rectOne = CGRectMake(10, 0, 200, 60)
    var rectTwo = CGRectMake(200, 0, 200, 60)
    var rectPlayerLbl = CGRectMake(20, 10, 200, 40)

    static var xpRect = CGRectMake(200, 20, 200, 40)
    static var o2Rect = CGRectMake(200, 40, 200, 40)
    static var metalRect = CGRectMake(200, 70, 200, 40)
    static var fuelRect = CGRectMake(200, 100, 200, 30)
    
    //labels for the current planet data
    static var o2RectPlanet = CGRectMake(10, 40, 200, 30)
    static var metalRectPlanet = CGRectMake(10, 70, 200, 30)
    static var fuelRectPlanet = CGRectMake(10, 100, 200, 30)
    
    static var rectCost = CGRectMake(10,35,200, 30)
    static var rectThree = CGRectMake(0,75,200, 30)
    
    var mainLabel: UILabel
    var playerLabel: UILabel

    var playerDataLbl: UILabel
    
    static let xpLabel = UILabel(frame: xpRect)
    static let o2Label = UILabel(frame: o2Rect)
    static let metalLabel = UILabel(frame: metalRect)
    static let fuelLabel = UILabel(frame: fuelRect)
    static var costLabel: UILabel = UILabel(frame: rectCost)

    required init?(coder aDecoder: NSCoder) {
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectPlayerLbl)
        MainTowerHUD.costLabel = UILabel(frame: MainTowerHUD.rectCost)
        playerDataLbl = UILabel(frame: rectTwo)
        super.init(coder: aDecoder)
        
    }
    
    init(x: CGFloat, y: CGFloat)
    {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        mainLabel = UILabel(frame: rectOne)
        playerLabel = UILabel(frame: rectPlayerLbl)
        playerDataLbl = UILabel(frame: rectTwo)
       // costLabel = UILabel(frame: rectCost)
        //im passing in location info because this inherites from the other views but this one does not need a specail location.
        super.init(frame:CGRectMake(20, 20, 666, 160))
        b.setTitle("Next", forState: UIControlState.Normal)
        b.titleLabel!.font = UIFont(name: "Square", size: 23.0)
        c.setTitle("Done", forState: UIControlState.Normal)
        c.titleLabel!.font = UIFont(name: "Square", size: 23.0)
        b.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        c.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        mainLabel.text = "Planet Data"//appDelegate?.gameScene?.xpLabel.text
        mainLabel.font = UIFont(name: "Square", size: 23.0)
       // mainLabel.sizeToFit()
        playerDataLbl.text = "Ship Data"//appDelegate?.gameScene?.xpLabel.text
        playerDataLbl.font = UIFont(name: "Square", size: 23.0)
        
        if let fuelText = appDelegate?.planetPickScene?.firstPlanet.fuel
        {
            playerLabel.text = "Fuel: \(fuelText)"
        }
        
        playerLabel.font = UIFont(name: "Square", size: 18.0)
        MainTowerHUD.costLabel.text = "Gold: "
        MainTowerHUD.costLabel.font = UIFont(name: "Square", size: 18.0)
        
        self.addSubview(mainLabel)
        self.addSubview(playerDataLbl)
        self.addSubview(playerLabel)
        self.addSubview(MainTowerHUD.costLabel)
       
        self.addSubview(MainTowerHUD.xpLabel)
        self.addSubview(MainTowerHUD.o2Label)
        self.addSubview(MainTowerHUD.metalLabel)
        self.addSubview(MainTowerHUD.fuelLabel)
        
        self.addSubview(b)
        self.addSubview(c)
        
        MainTowerHUD.costLabel.text = "cost"
        MainTowerHUD.xpLabel.font = UIFont(name: "Square", size: 18.0)
        MainTowerHUD.xpLabel.text = "xpLable"
        MainTowerHUD.o2Label.font = UIFont(name: "Square", size: 18.0)
        MainTowerHUD.o2Label.text = "o2Lable"
        MainTowerHUD.metalLabel.font = UIFont(name: "Square", size: 18.0)
        MainTowerHUD.metalLabel.text = "metaLable"
        MainTowerHUD.fuelLabel.font = UIFont(name: "Square", size: 18.0)
        MainTowerHUD.fuelLabel.text = "fuelLable"
        
        
        
        b.addTarget(self, action: #selector(MainTowerHUD.toSideScroll), forControlEvents:  UIControlEvents.TouchUpInside)
        c.addTarget(self, action: #selector(MainTowerHUD.endTowerGame), forControlEvents: UIControlEvents.TouchUpInside)
        self.backgroundColor = UIColor(red: 200, green: 155, blue: 34, alpha: 0.4)
    }
    func endTowerGame()
    {
        let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.goToPlanetPick()
    }
    func toSideScroll()
    {
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.goToTowerDefense()
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        /* Called when a touch begins */
//        let appDelegate =
//        UIApplication.sharedApplication().delegate as? AppDelegate
//        appDelegate?.gameScene?.mainHudIsUP = false
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
}
