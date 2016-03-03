//
//  PlanetPickScene.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 3/2/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation
import CoreData
import AudioKit

class PlanetPickScene: SKScene , SKPhysicsContactDelegate{
    
    var viewController: PlanetPickView!
    
    var backgroundNode: SKNode = SKNode()
    //var midgroundNode: SKNode = SKNode()
    //var foregroundNode: SKNode = SKNode()
    //var hudNode: SKNode = SKNode()
    //let shipNode = SKNode()
    //var scaleFactor: CGFloat = 0.0
    //var ship: SKNode = SKNode()
    
    //Enemy Factory
    
    static var planets : [Planet] =  [Planet]() // Stores all planets in galaxy
    static var scene : PlanetPickScene? = nil
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.blackColor()
        
        for (var i = 0; i < 100 ; i++) {
            PlanetPickScene.planets.append(Planet(size: 10 + CGFloat(arc4random_uniform(10)), position: getPlanetPosition(), color: getRandomColor()));
        }
        
        
        
    }
    
    func getPlanetPosition() -> CGPoint{
        
        
        let gridX = CGFloat(arc4random_uniform(50));
        let gridY = CGFloat(arc4random_uniform(50));
        return CGPoint(x: (gridX * 30), y: (gridY * 30));
    }
    
    func getRandomColor() -> SKColor {
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return SKColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0);
    }

}
