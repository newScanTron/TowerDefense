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
    let shipNode = SKNode()
    var lastTouch : CGPoint? = nil
    var firstTouch : CGPoint? = nil
    var previousTouch :CGPoint? = nil
    var touchDelta : CGPoint? = nil
    var touchTime : CGFloat = 0
    var ship: SKNode = SKNode()
    
    let shipSprite = SKSpriteNode(imageNamed: "Spaceship")
    let backgroundVelocity: CGFloat = 2.0
    var gameTime : CGFloat = 0
    var deltaTime : CGFloat = 0
    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    
    static var ships : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    static var scene : SideScrolScene? = nil
    
    override func didMoveToView(view: SKView) {

        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        self.view!.multipleTouchEnabled = true
        self.backgroundColor = SKColor.blackColor()
        self.initializingScrollingBackground()
        
        createShip()
        //foregroundNode.addChild(ship)
        SideScrolScene.scene?.addChild(shipSprite)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        firstTouch = touchLocation
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?){
        let touch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        if lastTouch == nil {
            lastTouch = firstTouch
        }
        touchDelta = CGPoint(x: touchLocation.x - lastTouch!.x, y: touchLocation.y - lastTouch!.y)
        lastTouch = touchLocation
        shipSprite.position = CGPoint(x: shipSprite.position.x + touchDelta!.x, y: shipSprite.position.y + touchDelta!.y) // (touchDelta!.x, touchDelta!.y)

    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouch = nil
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let previousLoc = touch
            
            if previousTouch == nil {

                
                
            }
            else{
                
            }
            //let zero : CGFloat = 0.0

            /*if shipSprite.physicsBody?.velocity.dy  < zero {
                moveUp()
            }
            else if shipSprite.physicsBody?.velocity.dy > zero {
                moveDown()
            }*/
        }
    }
    // Update function that moves background
    override func update(currentTime: NSTimeInterval) {
        
        deltaTime += 1.0
        gameTime = CGFloat(currentTime)
        
        
        
        let newEnemy = enemyFactory.getNextSSEnemy()
        if deltaTime > 3 {
            deltaTime = 0
            SideScrolScene.enemies.append(newEnemy)
            SideScrolScene.scene?.addChild(newEnemy.sprite)
        }
        self.moveBackground()
        let test : CGFloat = 0.00001

        
    }
    
    func createShip() -> SKNode {

        //shipNode.position = CGPoint(x: 200, y: 200)
        shipSprite.position = CGPoint(x: 200, y: 200)
        shipSprite.xScale = 0.1
        shipSprite.yScale = 0.1
        shipSprite.physicsBody?.dynamic = false
        shipSprite.physicsBody?.mass = 1
        shipSprite.physicsBody?.restitution = 1.0
        shipSprite.physicsBody?.linearDamping = 1.0
        shipSprite.physicsBody?.angularDamping = 1.0
        shipSprite.physicsBody?.allowsRotation = false
        shipSprite.zPosition = ZPosition.bullet
        shipSprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, 0.1))

        shipSprite.zRotation = CGFloat(-M_PI/2)
        
        //shipNode.addChild(shipSprite)
        
        return shipSprite
    }
    func moveUp() {
        shipSprite.physicsBody?.applyImpulse(CGVectorMake(0.0, 0.0001))
    }
    func moveDown() {
        shipSprite.physicsBody?.applyImpulse(CGVectorMake(0.0, -0.0001))
    }
    func moveForward() {
        shipSprite.physicsBody?.applyImpulse(CGVectorMake(0.001, 0.0))
    }
    func moveBack() {
        shipSprite.physicsBody?.applyImpulse(CGVectorMake(-0.001, 0.0))
    }
    func createMidgroundNode() -> SKNode {

        let node = SKSpriteNode(imageNamed:String("Rock2"))

        backgroundNode.addChild(node)
        
        return backgroundNode
    }
    
    func moveBackground(){
        self.enumerateChildNodesWithName("background", usingBlock: {(node, stop) -> Void in
            if let bg = node as? SKSpriteNode {
                bg.position = CGPoint(x: bg.position.x - self.backgroundVelocity, y: bg.position.y)
                
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y)
                }
            }
        
        })
    }
    func initializingScrollingBackground() {
        for var index = 0; index < 15; ++index{
            let bg = SKSpriteNode(imageNamed: "SideScrollbg")
            bg.position = CGPoint(x: index * Int(bg.size.width), y: 0)
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            bg.zPosition = ZPosition.background
            self.addChild(bg)
            
        }
    }
}