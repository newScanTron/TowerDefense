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
    
    var isZoomed = false
    
    var cameraNode: SKCameraNode!
    
    var touchLocation : CGPoint?
    
    var lastTouch : CGPoint? = nil
    var firstTouch : CGPoint? = nil
    
        var touchDelta : CGPoint? = nil
    var touchTimeDeleta : NSTimeInterval = 0.0
    
    var selectedPlanet : Planet?
    
    var currentCircle : SKShapeNode?
    
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
        
        cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: self.size.width / 4, y: self.size.height / 4)
        cameraNode.setScale(0.5)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        self.backgroundColor = SKColor.blackColor()
        
        for (var i = 0; i < 100 ; i++) {
            PlanetPickScene.planets.append(Planet(
                size: 10 + CGFloat(arc4random_uniform(10)),
                position: getPlanetPosition(),
                color: getRandomColor(),
                metal: Int(arc4random_uniform(100)),
                oxygen: Int(arc4random_uniform(100)),
                fuel: Int(arc4random_uniform(100))
            ));
        }
        
        let firstPlanet : Planet = PlanetPickScene.planets[Int(arc4random_uniform(UInt32(PlanetPickScene.planets.count)))]
        cameraNode.position = firstPlanet.position
        
        
        newDiscovery(firstPlanet.position.x, y: firstPlanet.position.y, r: 250);
        
        self.view!.multipleTouchEnabled = true;
        
    }
    
    func travelToPlanet(p : Planet) {
        self.viewController.goToScene()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        for t in touches {
//            //self.newDiscovery(t.locationInNode(self).x, y: t.locationInNode(self).y, r: 100);
//            touchLocation = t.locationInNode(self)
//            break;
//        }
        
        touchLocation = touches.first!.locationInNode(self)
        touchTimeDeleta = (event?.timestamp)!
        
        selectedPlanet = nil
        
        for p in PlanetPickScene.planets {
            if (getDistance(p.position,to: touchLocation!) < p.size) {
                selectedPlanet = p
                newDiscovery(p.position.x, y: p.position.y, r: 250)
                travelToPlanet(p);
                break
            }
        }
        
        if (selectedPlanet != nil) {
            print("M: \(selectedPlanet!.metal) O: \(selectedPlanet!.oxygen) F: \(selectedPlanet!.fuel) ")
        }
        
        
        
        firstTouch = touchLocation
        
        print("began: \(touches.count)")
        
        if (touches.count > 1) {
            print("count")
            let duration = 0.25
            if !isZoomed
            {
                // Lerp the camera to 100, 50 over the next half-second.
                self.cameraNode.runAction(SKAction.moveTo(CGPoint(x: touchLocation!.x, y: touchLocation!.y), duration: duration))
                self.cameraNode.runAction(SKAction.scaleTo(CGFloat(1), duration: duration))
                // self.cameraNode.setScale(1.5)
                isZoomed = true
                print("zoom")
            
            }
            else
            {
            
                self.cameraNode.runAction(SKAction.moveTo(CGPoint(x: touchLocation!.x, y: touchLocation!.y), duration: duration))
                self.cameraNode.runAction(SKAction.scaleTo(CGFloat(0.5), duration: duration))
                isZoomed = false
                print("unzoom")
            }
            
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //this gets set to nil for a check in the touchesMoved function
        let touch = touches.first
        
        let location = touch!.locationInNode(self)
        lastTouch = nil
        //this calulates how long the touch was and sends the player  to the planet they pressed on for atleast a set time interval
        touchTimeDeleta = (event?.timestamp)! - touchTimeDeleta
       
        
        for p in PlanetPickScene.planets {
            if (p.position.x - location.x <= 20)
            {
                currentPlanet = p
                if touchTimeDeleta > 0.7
                {
                    self.viewController.goToTowerDefense()
                     print("touchTimeDelta \(touchTimeDeleta)")
                }
            }
        }
        
            
    }

    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)

        
        if lastTouch == nil {
            lastTouch = firstTouch
        }
        touchDelta = CGPoint(x: touchLocation.x - lastTouch!.x, y: touchLocation.y - lastTouch!.y)
        lastTouch = touchLocation
        //these devisors are just floats that feel nice to make the differnece in width to height
        self.cameraNode.position.x -= touchDelta!.x/2.0
        self.cameraNode.position.y -= touchDelta!.y/1.25
        
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
//        let light : SKLightNode = SKLightNode();
//        light.lightColor = SKColor.whiteColor();
//        light.shadowColor = SKColor.blackColor()
//        light.position = CGPoint(x: x,y: y);
//        light.zPosition = ZPosition.tower-2;
//        light.falloff = r/1000
//        PlanetPickScene.scene?.addChild(light);
        
        currentCircle?.removeFromParent()
        
        currentCircle = SKShapeNode(circleOfRadius: r);
        currentCircle!.position = CGPoint(x: x, y: y);
        currentCircle!.lineWidth = 1.0;
        currentCircle!.glowWidth = 2.0;
        
        // Color fades as pulse progresses
        currentCircle!.fillColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0);
        currentCircle!.strokeColor = SKColor.whiteColor();
        
        currentCircle!.zPosition = ZPosition.tower-5;
        
        // Add circle back to scene
        PlanetPickScene.scene?.addChild(currentCircle!)
        
        
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
