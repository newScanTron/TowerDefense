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
    
    var lastTouchPosition: CGPoint = CGPoint(x: 0.0, y: 0.0);
    
    var offset : CGPoint = CGPoint(x: 0.0, y: 0.0);
    
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
        
        newDiscovery(1000, y: 1000, r: 1000);
        
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for t in touches {
            self.newDiscovery(t.locationInNode(self).x, y: t.locationInNode(self).y, r: 100);
            break;
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        for t in touches {
//            let deltaP : CGPoint = CGPoint(x: t.locationInNode(self).x-lastTouchPosition.x, y: t.locationInNode(self).y-lastTouchPosition.y);
//            offset.x += deltaP.x;
//            offset.y += deltaP.y;
//            lastTouchPosition = t.locationInNode(self);
//            break;
//        }
//        for p in PlanetPickScene.planets {
//            p.update(offset);
//        }
    }
    
    override func update(currentTime: CFTimeInterval) {
//        for p in PlanetPickScene.planets {
//            p.update(offset);
//        }
    }
    
    func getPlanetPosition() -> CGPoint{
        
        // 0 -> 2000
        
        let gridX = CGFloat(arc4random_uniform(50));
        let gridY = CGFloat(arc4random_uniform(50));
        return CGPoint(x: (gridX * 40), y: (gridY * 40));
    }
    
    func getRandomColor() -> SKColor {
        let randomHue: CGFloat = CGFloat(drand48())
        return SKColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 1.0);
    }
    
    func newDiscovery(x: CGFloat, y: CGFloat, r: CGFloat) {
        let circle : SKShapeNode = SKShapeNode(circleOfRadius: r);
        circle.position = CGPoint(x: x, y: y);
        circle.lineWidth = 0.0;
        circle.glowWidth = 0.0;
        
        // Color fades as pulse progresses
        circle.fillColor = SKColor(red: 0.0, green: 0.0, blue: 0.2, alpha: 1.0);
        circle.strokeColor = SKColor.whiteColor();
        
        circle.zPosition = ZPosition.tower-10;
        
        // Add circle back to scene
        PlanetPickScene.scene?.addChild(circle)
        
        for p in PlanetPickScene.planets {
            p.checkDiscovery(r, position: CGPoint(x: x, y: y));
        }
    }

}
