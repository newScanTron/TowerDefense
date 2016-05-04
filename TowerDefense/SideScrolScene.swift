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

    
    var viewController: PlanetPickView!

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
     var gameTime : CGFloat = 0
    var deltaTime : CGFloat = 0
    var ship :TowerBase? = nil
     var items : [Item] = [Item]()
    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    
     var ships : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
     var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func didMoveToView(view: SKView) {

        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        self.view!.multipleTouchEnabled = true
        self.backgroundColor = SKColor.blackColor()
        let path = NSBundle.mainBundle().pathForResource("StarsBG", ofType: "sks")
        let starParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        starParticle.position = CGPointMake(self.size.width/2, self.size.height)
        starParticle.targetNode = self.scene
        self.addChild(starParticle)
        

        let Thrusterpath = NSBundle.mainBundle().pathForResource("ShipThruster", ofType: "sks")
        let thrusterParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(Thrusterpath!) as! SKEmitterNode
        thrusterParticle.position = CGPointMake(0, 0)
        thrusterParticle.targetNode = self.scene
        midgroundNode.addChild(thrusterParticle)
        self.addChild(midgroundNode)


        ship = towerBuilder.BuildBaseShip()
        appDelegate.sideScrollScene!.ships.append(ship!)

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
        ship?.sprite.position = CGPoint(x: ship!.sprite.position.x + touchDelta!.x, y: ship!.sprite.position.y + touchDelta!.y)
        ship?.attackSprite.position = CGPoint(x: ship!.attackSprite.position.x + touchDelta!.x, y: ship!.attackSprite.position.y + touchDelta!.y)
        midgroundNode.position = CGPoint(x: (ship!.attackSprite.position.x - CGFloat(13.0)) + touchDelta!.x, y: ship!.attackSprite.position.y + touchDelta!.y)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouch = nil
        
        scene?.view?.paused = true
        
    }

    // Update function that moves background
    override func update(currentTime: NSTimeInterval) {

        
        deltaTime += 1.0
        appDelegate.sideScrollScene!.gameTime = CGFloat(currentTime)
        
        let newEnemy = enemyFactory.getNextSSEnemy()
        let newObstacle = enemyFactory.getObstacle()
        if deltaTime > 240 {
            intro = true
            deltaTime = 0
            scene!.view?.paused = true
            addEarth()
            earthSprite.physicsBody?.velocity.dx = -240
        }
        if intro == false {
            //SideScrolScene.enemies.append(newObstacle!)
            //SideScrolScene.scene?.addChild(newObstacle!.sprite)
        }
        if deltaTime > 40 && intro == true{
            deltaTime = 0
            appDelegate.sideScrollScene!.enemies.append(newEnemy)
            appDelegate.sideScrollScene!.scene?.addChild(newEnemy.sprite)
            //SideScrolScene.enemies.append(newObstacle!)
            //SideScrolScene.scene?.addChild(newObstacle!.sprite)
            
            for (var i = 0; i < appDelegate.sideScrollScene!.ships.count; i++)
            {
                let e = appDelegate.sideScrollScene!.ships[i]
                e.TriggerAttack()
            }

        }

        for (var i = 0; i < appDelegate.sideScrollScene!.enemies.count; i++)
        {
            let e = appDelegate.sideScrollScene!.enemies[i]
            
            e.TriggerAttack()
            e.moveMore()
            if e.CheckIfDead(){
                e.sprite.removeFromParent() 
                
                appDelegate.sideScrollScene!.enemies.removeAtIndex(i)
                i -= 1
            }
        }
        for (var i = 0; i < appDelegate.sideScrollScene!.items.count; i++) {
            let item = appDelegate.sideScrollScene!.items[i]
            if (item.destroyThis) {
                item.destroy()
                appDelegate.sideScrollScene!.items.removeAtIndex(i)
                i -= 1;
            }
            else {
                item.update()
            }
        }
    }
    func addEarth() {

        earthSprite.position = CGPoint(x: 1200, y: -200)
        earthSprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.25, 0.25))
        earthSprite.physicsBody?.dynamic = true
        earthSprite.physicsBody?.mass = 1
        earthSprite.physicsBody?.velocity.dx = -200
        earthSprite.physicsBody?.velocity.dy = -10
        
        appDelegate.sideScrollScene!.scene?.addChild(earthSprite)

    }

    func createMidgroundNode() -> SKNode {

        let node = SKSpriteNode(imageNamed:String("smallstar"))
        //node.position.x
        backgroundNode.addChild(node)
        
        return backgroundNode
    }
    //this method is called whenever two physicsBodies contact.  The appropriate logic is called depending which objects did hte contacting.
    func didBeginContact(contact: SKPhysicsContact) {
        // Bitiwse OR the bodies' categories to find out what kind of contact we have
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
            //this first case is executed when a tower bullet hits a enemy.
        case CategoryMask.Enemy | CategoryMask.TowerBullet:
            
            for e in appDelegate.sideScrollScene!.enemies{
                if e.sprite == contact.bodyA.node{
                    let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage
                    //giveXp(e)
                    e.UpdateLabel()
                    contactTest.destroy()
                    //appDelegate!.conductor.hitEnemyPlaySound(0.0125, e: e)
                    contact.bodyB.node?.removeFromParent()
                } else if e.sprite == contact.bodyB.node{
                    let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage
                    //giveXp(e)
                    e.UpdateLabel()
                    contactTest.destroy()
                    //appDelegate!.conductor.hitEnemyPlaySound(0.02, e: e)
                    contact.bodyA.node?.removeFromParent()
                }
            }
            //this case is if an enemy bullet has hit a tower.
        case CategoryMask.Tower | CategoryMask.EnemyBullet:
            
            for t in appDelegate.sideScrollScene!.ships{
                
                if t.sprite == contact.bodyA.node{
                    let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(contactTest.damage)
                    //t.UpdateLabel()
                    contactTest.destroy()
                    //conductor.hitTowerPlaySoundForDuration(0.02)
                    contact.bodyB.node?.removeFromParent()
                } else if t.sprite == contact.bodyB.node{
                    let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(contactTest.damage)
                    //t.UpdateLabel()
                    //conductor.hitTowerPlaySoundForDuration(0.02)
                    contactTest.destroy()
                    contact.bodyA.node?.removeFromParent()
                }
            }
            
        default:
            
            print("other collision: \(contactMask)")
        }
    }
}