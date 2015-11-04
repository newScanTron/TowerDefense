//
//  EnemyFactory.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyFactory
{
    init(){}
    
    func CreateEnemy(scene: SKScene) -> EnemyBase{
        
        //create sprite
        let bison = SKSpriteNode(imageNamed: "Spaceship")

        let enemy = EnemyBase(sprite: bison, scene: scene)
        
        //add the bison to the scene
        
        
        
        return enemy
    }
   
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
}