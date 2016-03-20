//
//  Planet.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 3/2/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import SpriteKit
import Foundation

class Planet {
    
    
    
    var circle : SKShapeNode?
    var position : CGPoint;
    var rotation : CGFloat;
    var size : CGFloat;
    var color : SKColor
    var sprite : SKSpriteNode?
    var discovered : Bool = false;
    
    var metal : Int = 0;
    var oxygen : Int = 0;
    var fuel : Int = 0;
    var mapArray = Array(count: 64, repeatedValue: Array(count: 48, repeatedValue: 0))
    
    
    init (size : CGFloat, position : CGPoint, color : SKColor, metal : Int, oxygen : Int, fuel : Int) {
        self.position = position
        self.size = size
        self.color = color
        self.rotation = CGFloat(arc4random_uniform(628))/100.0
        self.metal = metal
        self.oxygen = oxygen
        self.fuel = fuel
        
        self.getColor();
        
        
        //self.discover();
        self.makeMap()
    }
    
    func getColor() {
        let sum : CGFloat = CGFloat(metal + oxygen + fuel)
        let mP = CGFloat(metal)/sum
        let oP = CGFloat(oxygen)/sum
        let fP = CGFloat(fuel)/sum
        let color = SKColor(red: mP, green: fP, blue: oP, alpha: 1.0)
        self.color = color
    }
    
    func checkDiscovery(distance: CGFloat, position: CGPoint) {
        if (getDistance(self.position, to: position) < distance) {
            discover();
        }
    }
    
    func discover() {
        discovered = true;
        
        sprite = SKSpriteNode(imageNamed: "planet1") // This is effectively the "defense" sprite
        
//        sprite!.xScale = size/20
//        sprite!.yScale = size/20
        sprite!.size = CGSize(width: size*2, height: size*2);
        
        sprite!.zRotation = rotation
        
        sprite!.position = self.position;
        sprite!.lightingBitMask = 0x00000001
//        sprite!.shadowCastBitMask = 0x00000001
//        sprite!.shadowedBitMask = 0x00000001
        sprite!.zPosition = ZPosition.tower-1;
        sprite!.color = color;
        sprite!.colorBlendFactor = 0.8;
        
        PlanetPickScene.scene?.addChild(sprite!)
        
//        circle = SKShapeNode(circleOfRadius: size)
//        circle?.position = position;
//        circle?.lineWidth = 0.0;
//        circle?.glowWidth = 0.0;
//        
//        // Color fades as pulse progresses
//        circle?.fillColor = color;
//        circle?.strokeColor = SKColor.blackColor();
//        
//        circle?.zPosition = ZPosition.tower-1;
//        
//        // Add circle back to scene
//        PlanetPickScene.scene?.addChild(circle!)
    }
    
    func update(offset : CGPoint) {
        circle?.position = CGPoint(x: self.position.x + offset.x, y: self.position.y + offset.y);
    }
    //function to build a 2d array for placement of objects in the TowerDefenseScene
    func makeMap()
    {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        let towDefScene = appDelegate?.gameScene!
        //say my icons are 32 by 32 then we will divide the scene height and width by that to allow the array to represent the location of the
        let widthOffset =  (towDefScene?.size.width)!/32
        let heightOffset =  (towDefScene?.size.height)!/32
        for (var i : CGFloat = 0; i < widthOffset; i++)
        {
            for (var j : CGFloat = 0; j < heightOffset; j++)
            {
                
                let ii = Int(i)
                let jj = Int(j)
             
                if (i == 0 || i == widthOffset-1 || j == heightOffset-1 || j == 0)
                {
                    
                   mapArray[ii][jj] = 0
                    
                   
                }
                else {
                    let randNum = arc4random_uniform(UInt32(3))
                    mapArray[ii][jj] = Int(randNum)
                    
                }
            
            }
        }
        
        
    }
}
