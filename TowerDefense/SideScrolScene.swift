//
//  SideScrolScene.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/5/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation
import CoreData
import AudioKit

class SideScrolScene: SKScene , SKPhysicsContactDelegate{

    
    var viewController: SideScroll!

    var backgroundNode: SKNode = SKNode()
    var midgroundNode: SKNode = SKNode()
    var foregroundNode: SKNode = SKNode()
    var hudNode: SKNode = SKNode()
    
    var scaleFactor: CGFloat = 0.0
    var ship: SKNode = SKNode()
    var actionMoveUp = SKAction()
    var actionMoveDown = SKAction()
    let backgroupVelocity: CGFloat = 3.0
    
    static var ships : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    static var scene : SideScrolScene? = nil
    
    override func didMoveToView(view: SKView) {
        
        //backgroundNode = createBackgroundNode()
        foregroundNode = SKNode()
        ship = createShip()
        foregroundNode.addChild(ship)
        scaleFactor = 3.0
        

        //self.addChild(backgroundNode)
        
        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        self.view!.multipleTouchEnabled = true
        self.backgroundColor = SKColor.blackColor()
        self.initializingScrollingBackground()
        self.addChild(foregroundNode)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if location.y > ship.position.y {
                ship.runAction(actionMoveUp)
            }
            else{
                ship.runAction(actionMoveDown)
            }
        }
    }
    
    // Update function that moves background
    override func update(currentTime: NSTimeInterval) {
        self.moveBackground()
    }
    
    func createShip() -> SKNode {
        let shipNode = SKNode()
        shipNode.position = CGPoint(x: 100, y: 0)
        
        let sprite = SKSpriteNode(imageNamed: "Spaceship")
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        
        shipNode.addChild(sprite)
        actionMoveUp = SKAction.moveByX(0, y: 30, duration: 0.1)
        actionMoveDown = SKAction.moveByX(0, y: -30, duration: 0.1)
        
        return shipNode
    }
    
    func createBackgroundNode() -> SKNode {
        
        let ySpacing = 64.0 * scaleFactor
        
        for index in 0...3 {
            let node = SKSpriteNode(imageNamed:String("BackgroundSide", index + 1))
            
            node.setScale(scaleFactor)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            node.position = CGPoint(x: self.size.width / 2, y: ySpacing * CGFloat(index))
            
            backgroundNode.addChild(node)
        }
        return backgroundNode
    }
    
    func moveBackground(){
        self.enumerateChildNodesWithName("background", usingBlock: {(node, stop) -> Void in
            if let bg = node as? SKSpriteNode {
                bg.position = CGPoint(x: bg.position.x - self.backgroupVelocity, y: bg.position.y)
                
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y)
                }
            }
        
        })
    }
    func initializingScrollingBackground() {
        for var index = 0; index < 15; ++index{
            let bg = SKSpriteNode(imageNamed: "gridBG")
            bg.position = CGPoint(x: index * Int(bg.size.width), y: 0)
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            self.addChild(bg)
            
        }
    }
}