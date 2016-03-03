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
    
    
    init (size : CGFloat, position : CGPoint, color : SKColor) {
        circle = SKShapeNode(circleOfRadius: size)
        circle?.position = position;
        circle?.lineWidth = 1.0;
        circle?.glowWidth = size/4.0;
        
        // Color fades as pulse progresses
        circle?.fillColor = color;
        circle?.strokeColor = SKColor.blackColor();
        
        circle?.zPosition = ZPosition.tower-1;
        
        // Add circle back to scene
        PlanetPickScene.scene?.addChild(circle!)    }
    
}
