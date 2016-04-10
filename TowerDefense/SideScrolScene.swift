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

    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    var viewController: SideScroll!

    var backgroundNode: SKNode = SKNode()
    var midgroundNode: SKNode = SKNode()
    var foregroundNode: SKNode = SKNode()
    var shieldParentNode : SKNode = SKNode()
    var shieldNode : SKNode = SKNode()
    var shieldNode1 : SKNode = SKNode()
    var hudNode: SKNode = SKNode()

    var intro : Bool = false
    var superWeapon : Bool = false
    var inTransit : Bool = false
    
    var lastTouch : CGPoint? = nil
    var firstTouch : CGPoint? = nil
    var previousTouch :CGPoint? = nil
    var touchDelta : CGPoint? = nil
    var touchTime : CGFloat = 0
    let earthSprite = SKSpriteNode(imageNamed: "rock32by32")
    let livesLeft1 = SKSpriteNode(imageNamed: "Spaceship")
    let livesLeft2 = SKSpriteNode(imageNamed: "Spaceship")
    let livesLeft3 = SKSpriteNode(imageNamed: "Spaceship")
    let enemiesLabel = SKLabelNode(fontNamed:"Square")
    static var gameTime : CGFloat = 0
    var deltaTime : CGFloat = 0
    var ship :TowerBase? = nil
    static var items : [Item] = [Item]()
    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    
    static var ships : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    var items : [Item] = [Item]()
    static var scene : SideScrolScene? = nil

    
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
        
        let Weaponpath = NSBundle.mainBundle().pathForResource("WeaponParticle", ofType: "sks")
        let superWeaponParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(Weaponpath!) as! SKEmitterNode
        superWeaponParticle.position = CGPointMake(0, 0)
        superWeaponParticle.targetNode = self.scene
        
        let Shieldpath = NSBundle.mainBundle().pathForResource("Shield", ofType: "sks")
        let shieldParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(Shieldpath!) as! SKEmitterNode
        let shieldParticle1 = NSKeyedUnarchiver.unarchiveObjectWithFile(Shieldpath!) as! SKEmitterNode
        shieldParticle.position = CGPointMake(0, 52.5)
        shieldParticle.targetNode = self.scene
        shieldParticle1.position = CGPointMake(0, -52.5)
        shieldParticle1.targetNode = self.scene
        
        enemiesLabel.fontSize = 45
        enemiesLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height - 30)
        enemiesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        foregroundNode.physicsBody?.dynamic = true
        foregroundNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(10.0, 10.0))
        foregroundNode.addChild(superWeaponParticle)
        shieldNode.addChild(shieldParticle)
        shieldNode1.addChild(shieldParticle1)
        
        midgroundNode.addChild(thrusterParticle)
        shieldParentNode.addChild(shieldNode)
        shieldParentNode.addChild(shieldNode1)
        
        self.addChild(shieldParentNode)
        self.addChild(midgroundNode)
        self.addChild(enemiesLabel)
        
        ship = towerBuilder.BuildBaseShip()
        SideScrolScene.ships.append(ship!)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        scene!.view?.paused = false
        let touch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        firstTouch = touchLocation
        
        if (touches.count > 1)
        {
            if foregroundNode.parent == nil {
                SideScrolScene.scene!.addChild(foregroundNode)
            }

            superWeapon = true
        }
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
        shieldParentNode.position = CGPoint(x: ship!.sprite.position.x + touchDelta!.x, y: ship!.sprite.position.y + touchDelta!.y)
        ship?.attackSprite.position = CGPoint(x: ship!.attackSprite.position.x + touchDelta!.x, y: ship!.attackSprite.position.y + touchDelta!.y)
        midgroundNode.position = CGPoint(x: (ship!.attackSprite.position.x - CGFloat(13.0)) + touchDelta!.x, y: ship!.attackSprite.position.y + touchDelta!.y)
        if foregroundNode.parent != nil && inTransit == false{
            foregroundNode.position = CGPoint(x: (ship!.attackSprite.position.x + CGFloat(33.0)) + touchDelta!.x, y: ship!.attackSprite.position.y + touchDelta!.y)
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouch = nil
        
        if superWeapon == true {
            foregroundNode.physicsBody?.velocity.dx = 500
            inTransit = true
            superWeapon = false
        }
        //scene?.view?.paused = true
        
    }

    // Update function that moves background
    override func update(currentTime: NSTimeInterval) {

        
        deltaTime += 1.0
        SideScrolScene.gameTime = CGFloat(currentTime)
        
        //Removes SuperWeapon parent node and resets inTransit flag
        if foregroundNode.position.x > scene?.size.width {
            foregroundNode.removeFromParent()
            inTransit = false
        }
        
        //Need to move to Tower class or its own
        shieldParentNode.zRotation += CGFloat(-M_PI/16)
        
        let newObstacle = enemyFactory.getObstacle()
        
        if deltaTime > 50 {
            intro = true
            deltaTime = 0
            //scene!.view?.paused = true
            addEarth()
            earthSprite.physicsBody?.velocity.dx = -240
        }
        if intro == false {
            //SideScrolScene.enemies.append(newObstacle!)
            //SideScrolScene.scene?.addChild(newObstacle!.sprite)
        }
        if deltaTime > 40 && intro == true{
            deltaTime = 0
            let newEnemy = enemyFactory.getNextSSEnemy()
            SideScrolScene.enemies.append(newEnemy!)
            SideScrolScene.scene?.addChild(newEnemy!.sprite)
            //SideScrolScene.enemies.append(newObstacle!)
            //SideScrolScene.scene?.addChild(newObstacle!.sprite)
            
            for (var i = 0; i < SideScrolScene.ships.count; i++)
            {
                let e = SideScrolScene.ships[i]
                if superWeapon == false {
                    e.TriggerAttack()
                }
            }

        }
        
        if deltaTime / 10 == 1 || deltaTime / 10 == 2 || deltaTime / 10 == 3 || deltaTime / 5 == 1 && intro == true{
            for (var i = 0; i < SideScrolScene.ships.count; i++)
            {
                let e = SideScrolScene.ships[i]
                if superWeapon == false {
                    e.TriggerAttack()
                }
            }
        }
        for (var i = 0; i < SideScrolScene.enemies.count; i++)
        {
            let e = SideScrolScene.enemies[i]
            
            e.TriggerAttack()
            e.moveMore()
            if e.CheckIfDead(){
                e.sprite.removeFromParent() 
                
                SideScrolScene.enemies.removeAtIndex(i)
                i -= 1
            }
        }
        /*for (var i = 0; i < SideScrolScene.items.count; i++) {
            let item = SideScrolScene.items[i]
            if (item.destroyThis) {
                item.destroy()
                SideScrolScene.items.removeAtIndex(i)
                i -= 1;
            }
            else {
                item.update()
            }
        }*/
        for (var i = 0; i < appDelegate!.sideScrollScene!.items.count; i++) {
            let item = appDelegate!.sideScrollScene!.items[i]
            if (item.destroyThis) {
                item.destroy()
                appDelegate!.sideScrollScene!.items.removeAtIndex(i)
                i -= 1;
            }
            else {
                item.update()
            }
        }
    }
    func addEarth() {

        earthSprite.position = CGPoint(x: 1200, y: 100)
        earthSprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.25, 0.25))
        earthSprite.physicsBody?.dynamic = true
        earthSprite.physicsBody?.mass = 1
        earthSprite.physicsBody?.velocity.dx = -200
        earthSprite.physicsBody?.velocity.dy = -10
        earthSprite.xScale = 2
        earthSprite.yScale = 2
        
        livesLeft1.xScale = 0.06
        livesLeft1.yScale = 0.06
        
        livesLeft1.position = CGPointMake(30, SideScrolScene.scene!.size.height - 40)
        
        
        livesLeft2.xScale = 0.06
        livesLeft2.yScale = 0.06
        
        livesLeft2.position = CGPointMake(60, SideScrolScene.scene!.size.height - 40)
        
        livesLeft3.xScale = 0.06
        livesLeft3.yScale = 0.06
        
        livesLeft3.position = CGPointMake(90, SideScrolScene.scene!.size.height - 40)
        
        
        SideScrolScene.scene?.addChild(livesLeft1)
        SideScrolScene.scene?.addChild(livesLeft2)
        SideScrolScene.scene?.addChild(livesLeft3)
        SideScrolScene.scene?.addChild(earthSprite)

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
            print("Enemy or TowerBullet collide")
            for e in SideScrolScene.enemies{
                if e.sprite == contact.bodyA.node{
                    let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage
                    //giveXp(e)
                    e.UpdateLabel()
                    contactTest.sideScrollTrigger()
                    //appDelegate!.conductor.hitEnemyPlaySound(0.0125, e: e)
                    contact.bodyB.node?.removeFromParent()
                } else if e.sprite == contact.bodyB.node{
                    let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage
                    //giveXp(e)
                    e.UpdateLabel()
                    contactTest.sideScrollTrigger()
                    //appDelegate!.conductor.hitEnemyPlaySound(0.02, e: e)
                    contact.bodyA.node?.removeFromParent()
                }
            }
            //this case is if an enemy bullet has hit a tower.
        case CategoryMask.Tower | CategoryMask.EnemyBullet:
            
            for t in SideScrolScene.ships{
                
                if t.sprite == contact.bodyA.node{
                    let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(contactTest.damage)
                    //t.UpdateLabel()
                    contactTest.sideScrollTrigger()
                    //conductor.hitTowerPlaySoundForDuration(0.02)
                    contact.bodyB.node?.removeFromParent()
                } else if t.sprite == contact.bodyB.node{
                    let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(contactTest.damage)
                    //t.UpdateLabel()
                    //conductor.hitTowerPlaySoundForDuration(0.02)
                    contactTest.sideScrollTrigger()
                    contact.bodyA.node?.removeFromParent()
                }
            }
            
        case CategoryMask.Enemy | CategoryMask.Tower:
             print("Enemy or Tower collide")
            for t in SideScrolScene.ships{
                
                if t.sprite == contact.bodyA.node{
                    //let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(1000)
                    //t.UpdateLabel()
                    //contactTest.sideScrollTrigger()
                    //conductor.hitTowerPlaySoundForDuration(0.02)
                    contact.bodyB.node?.removeFromParent()
                } else if t.sprite == contact.bodyB.node{
                    //let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(1000)
                    //t.UpdateLabel()
                    //conductor.hitTowerPlaySoundForDuration(0.02)
                    //contactTest.sideScrollTrigger()
                    contact.bodyA.node?.removeFromParent()
                }
            }

            
        default:
            
            print("other collision: \(contactMask)")
        }
    }
}