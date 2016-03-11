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
    var size : CGFloat;
    var color : SKColor
    var discovered : Bool = false;
    
    var metal : CGFloat = 0.0;

    
    
    init (size : CGFloat, position : CGPoint, color : SKColor) {
        self.position = position;
        self.size = size;
        self.color = color;
        //self.discover();
    }
    
    func checkDiscovery(distance: CGFloat, position: CGPoint) {
        if (getDistance(self.position, to: position) < distance) {
            discover();
        }
    }
    
    func discover() {
        discovered = true;
        circle = SKShapeNode(circleOfRadius: size)
        circle?.position = position;
        circle?.lineWidth = 0.0;
        circle?.glowWidth = 0.0;
        
        // Color fades as pulse progresses
        circle?.fillColor = color;
        circle?.strokeColor = SKColor.blackColor();
        
        circle?.zPosition = ZPosition.tower-1;
        
        // Add circle back to scene
        PlanetPickScene.scene?.addChild(circle!)
    }
    
    func update(offset : CGPoint) {
        circle?.position = CGPoint(x: self.position.x + offset.x, y: self.position.y + offset.y);
    }
    
}
