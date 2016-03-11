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
    var intro : Bool = false
    var lastTouch : CGPoint? = nil
    var firstTouch : CGPoint? = nil
    var previousTouch :CGPoint? = nil
    var touchDelta : CGPoint? = nil
    var touchTime : CGFloat = 0
    let earthSprite = SKSpriteNode(imageNamed: "earth10")
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
        var path = NSBundle.mainBundle().pathForResource("StarsBG", ofType: "sks")
        var starParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        starParticle.position = CGPointMake(self.size.width/2, self.size.height)
        starParticle.targetNode = self.scene
        self.addChild(starParticle)
        
        var Thrusterpath = NSBundle.mainBundle().pathForResource("ShipThruster", ofType: "sks")
        var thrusterParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(Thrusterpath!) as! SKEmitterNode
        thrusterParticle.position = CGPointMake(0, 0)
        thrusterParticle.targetNode = self.scene
        midgroundNode.addChild(thrusterParticle)
        self.addChild(midgroundNode)

        //self.initializingScrollingBackground()
        
        createShip()
        //foregroundNode.addChild(ship)
        SideScrolScene.scene?.addChild(shipSprite)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        scene!.view?.paused = false
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
        shipSprite.position = CGPoint(x: shipSprite.position.x + touchDelta!.x, y: shipSprite.position.y + touchDelta!.y)
        midgroundNode.position = CGPoint(x: (shipSprite.position.x - CGFloat(13.0)) + touchDelta!.x, y: shipSprite.position.y + touchDelta!.y)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouch = nil
        
        scene?.view?.paused = true
        
    }
    // Update function that moves background
    override func update(currentTime: NSTimeInterval) {
        
        deltaTime += 1.0
        
        gameTime = CGFloat(currentTime)
        
        let newEnemy = enemyFactory.getNextSSEnemy()
        let newObstacle = enemyFactory.getObstacle()
        if deltaTime > 240 {
            intro = true
            deltaTime = 0
            scene!.view?.paused = true
            addEarth()
            earthSprite.physicsBody?.velocity.dx = -20
        }
        if intro == false {
            SideScrolScene.enemies.append(newObstacle!)
            SideScrolScene.scene?.addChild(newObstacle!.sprite)
        }
        if deltaTime > 40 && intro == true{
            deltaTime = 0
            SideScrolScene.enemies.append(newEnemy)
            SideScrolScene.scene?.addChild(newEnemy.sprite)
            SideScrolScene.enemies.append(newObstacle!)
            SideScrolScene.scene?.addChild(newObstacle!.sprite)
        }
        
        //self.moveBackground()
        
        for (var i = 0; i < SideScrolScene.enemies.count; i++)
        {
            let e = SideScrolScene.enemies[i]
            e.TriggerAttack()
            e.moveMore()
        }
    }
    func addEarth() {

        earthSprite.position = CGPoint(x: 1200, y: -200)
        earthSprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.25, 0.25))
        earthSprite.physicsBody?.dynamic = true
        earthSprite.physicsBody?.mass = 1
        earthSprite.physicsBody?.velocity.dx = -200
        earthSprite.physicsBody?.velocity.dy = -10
        
        SideScrolScene.scene?.addChild(earthSprite)


    }
    func createShip() -> SKNode {

        let ship : TowerBase = towerBuilder.BuildBaseShip()
        
        //shipNode.position = CGPoint(x: 200, y: 200)
        /*shipSprite.position = CGPoint(x: 200, y: 200)

        shipSprite.physicsBody?.dynamic = false
        shipSprite.physicsBody?.mass = 1
        shipSprite.physicsBody?.restitution = 1.0
        shipSprite.physicsBody?.linearDamping = 1.0
        shipSprite.physicsBody?.angularDamping = 1.0
        shipSprite.physicsBody?.allowsRotation = false
        shipSprite.zPosition = ZPosition.tower
        shipSprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, 0.1))

        */
        shipSprite.zRotation = CGFloat(-M_PI/2)
        shipSprite.xScale = 0.1
        shipSprite.yScale = 0.1
        //shipNode.addChild(shipSprite)
        /*func attack(){
            Bullet(_shooter: shipSprite, _target: shipSprite.position + CGPointMake(x: shipSprite.position.x + 200, y: shipSprite.position.y), _speed: speed, _damage: 10, size: 15, shotByEnemy: true)
            
        }*/
        return shipSprite
    }

    func createMidgroundNode() -> SKNode {

        let node = SKSpriteNode(imageNamed:String("smallstar"))
        //node.position.x
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