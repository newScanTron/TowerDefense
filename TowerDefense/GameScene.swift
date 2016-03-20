//
//  GameScene.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/27/15.
//  Copyright (c) 2015 Chris Murphy. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation
import CoreData
import AudioKit

class GameScene: SKScene , SKPhysicsContactDelegate{

    var viewController: GameViewController!
    let appDelegate = 
    UIApplication.sharedApplication().delegate as? AppDelegate
    //let conductor = Conductor()
    let myLabel = SKLabelNode(fontNamed:"Square")
    let xpLabel = SKLabelNode(fontNamed:"Square")
    let o2Label = SKLabelNode(fontNamed: "Square")
    let metalLabel = SKLabelNode(fontNamed: "Square")
    let fuelLabel = SKLabelNode(fontNamed: "Square")
    let enemiesLabel = SKLabelNode(fontNamed:"Square")
    let waveLabel = SKLabelNode(fontNamed: "Square")
    var background : SKSpriteNode? = nil
    let towerTotal = 20
    let bossNode: EnemyBase? = nil
    let cero = 0
    var gameOver : Bool = false
    var nextWaveDelay = false
    var selectedNodes = [UITouch:SKSpriteNode]()
     var desTouches = [UITouch]()
    //camera stuff
    var cameraNode: SKCameraNode!
    var lastTouch : CGPoint? = nil
    var firstTouch : CGPoint? = nil
    var lastTouch2 : CGPoint? = nil
    var firstTouch2 : CGPoint? = nil
    var previousTouch :CGPoint? = nil
    var touchDelta : CGPoint? = nil
    var touchTime : CGFloat = 0
    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    //making all of these static allows us to not have to pass them around method calls
     var towers : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
     var items : [Item] = [Item]()
     var spawnLocs : [CGPoint] = [CGPoint]()
    //static var boss : [EnemyBase] = [EnemyBase]()
    var gameTime : CGFloat = 0
    var deltaTime : CGFloat = 0
    var totalTime : CGFloat = 0.0
    static var scene : GameScene? = nil
    //bool actions
    var mainHudIsUP = false
    var mainBuild = false
    var odd : Bool = false // This is just for switching between tower types until we get tower building fully functional
    var towerHardLimit : Int = 20
    
    
    override func didMoveToView(view: SKView) {

        gameOver = false
     
        cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: self.size.width / 4, y: self.size.height / 4)
        cameraNode.setScale(0.5)
        self.addChild(cameraNode)
        self.camera = cameraNode

        
        let labelOffset : CGFloat = -scene!.size.width / 2 + 5
        let labelOffsetY : CGFloat = scene!.size.height/2
        print(scene?.size.width, scene?.size.height)
        waveLabel.fontSize = 65
        waveLabel.position = CGPoint(x: labelOffset, y: labelOffsetY - 60)
        waveLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        myLabel.text = "DEFFEND!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x: labelOffset, y: labelOffsetY - 100);
        myLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        xpLabel.fontSize = 45;
        xpLabel.position = CGPoint(x: labelOffset, y: labelOffsetY - 140);
        xpLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        enemiesLabel.fontSize = 45
        enemiesLabel.position = CGPoint(x: labelOffset, y: labelOffsetY - 180)
        enemiesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left

        metalLabel.fontSize = 45;
        metalLabel.position = CGPoint(x: labelOffset, y: labelOffsetY - 220);
        metalLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        metalLabel.text = "metal label"
        
        o2Label.fontSize = 45;
        o2Label.position = CGPoint(x: labelOffset, y: labelOffsetY - 260)
        o2Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        o2Label.text = "o2 lael"

        fuelLabel.fontSize = 45;
        fuelLabel.position = CGPoint(x: labelOffset, y: labelOffsetY - 300)
        fuelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        fuelLabel.text = "fuelLabel"
        
        
        cameraNode.addChild(waveLabel)
        cameraNode.addChild(o2Label )
       cameraNode.addChild(metalLabel)
        cameraNode.addChild(fuelLabel)
        waveLabel.fontColor = UIColor(red: 1.0, green: 0.0 / 255, blue: 0.0 / 255, alpha: 1.0)
        waveLabel.zPosition = ZPosition.bullet
        
        cameraNode.addChild(enemiesLabel)
        enemiesLabel.zPosition = ZPosition.bullet
        
        cameraNode.addChild(myLabel)
        myLabel.zPosition = ZPosition.bullet
        
        cameraNode.addChild(xpLabel)
        xpLabel.zPosition = ZPosition.bullet


        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        self.view!.multipleTouchEnabled = true
        //get the location of the spawn points
        enumerateChildNodesWithName("spawn", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            // do something with node or stop
            self.spawnLocs.append(node.position)
            
        })
        
    }
    
    //helper to make towers
    func addTower(location: CGPoint, touch: UITouch)
    {

        let touchLocation = touch.locationInView(self.view!)
        let tower : TowerBase = towerBuilder.BuildBaseTower(location)
        
        if (addGold(-100)) {
            appDelegate!.gameScene!.towers.append(tower)


            towerBuilder.addUpgradeView(tower, location: touchLocation, gameScene: self)

        }
    
    }
    //this function we are mostly just grabbing the differnet locations of the touch events
    //we are only currently interested in the first two and disregarding any other touches.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        var counter = 0
        for touch in touches {
            desTouches.append(touch)
            counter++
        }
        
        if (touches.count > 1)
        {
            firstTouch2 = desTouches[1].locationInNode(self)
            let duration = 0.25
            if !isZoomed
            {
                // Lerp the camera to 100, 50 over the next half-second.
                self.cameraNode.runAction(SKAction.moveTo(CGPoint(x: touchLocation.x, y: touchLocation.y), duration: duration))
                self.cameraNode.runAction(SKAction.scaleTo(CGFloat(1), duration: duration))
               // self.cameraNode.setScale(1.5)
                isZoomed = true
            
                
            }
            else
            {
               
                self.cameraNode.runAction(SKAction.moveTo(CGPoint(x: touchLocation.x, y: touchLocation.y), duration: duration))
                self.cameraNode.runAction(SKAction.scaleTo(CGFloat(0.5), duration: duration))
                isZoomed = false
            }
        }
        
       
        firstTouch = touchLocation
        scaleScale = 0
        
        
    }
    //some class level variables to keep track of the last touch locations
    var touchScale : CGFloat = 0.0
    var scaleScale : CGFloat = 0.0
    var scaleSet = false
    var lastTouchSet = false
    var isZoomed = false
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        var counter = 0
        for touch in touches {
            desTouches.append(touch)
            counter++
        }
   
            if lastTouch == nil {
                lastTouch = firstTouch
            }
            touchDelta = CGPoint(x: touchLocation.x - lastTouch!.x, y: touchLocation.y - lastTouch!.y)
            lastTouch = touchLocation
            //these devisors are just floats that feel nice to make the differnece in width to height
            self.cameraNode.position.x -= touchDelta!.x/2.0
            self.cameraNode.position.y -= touchDelta!.y/1.25
        
    
    }
    
    //
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //this gets set to nil for a check in the touchesMoved function
        lastTouch = nil
        lastTouch2 = nil
        
        desTouches.removeAll()
        /* Called when a touch begins */
        let touch = touches.first
        
        let location = touch!.locationInNode(self)
       let viewLocation = touch!.locationInView(self.view!)

        
        //this is just a thing to tringer conduvtor stuff.
        if touches.count > 2
        {
            
            appDelegate!.conductor.recursiveNotesRandom(5, maxLength: 2.0)

        }
        if touch?.tapCount > 1 && !mainBuild
        //if touches.count > 1 && !mainBuild
        {
            let mainTower = towerBuilder.BuildMainTower(location)
            appDelegate!.gameScene!.towers.append(mainTower)
            mainBuild = true
            return
        }
        else if touch?.tapCount > 1
        {
        //if we found a tower open menu else add tower
        if appDelegate!.gameScene!.towers.count <= towerHardLimit
        {
            
            addTower(location, touch: touch!)
            return
        }
        }
        for each in appDelegate!.gameScene!.towers
        {
            if each.sprite.containsPoint(location)
            {
                //conductor.playWaveMelody()
                if (each.sprite.name == "mainTower" && !mainHudIsUP)
                {
                    towerBuilder.addMainUpgradView(each, location: viewLocation, gameScene: self)
                    mainHudIsUP = true
                }
                else if each.sprite.name == "tower"
                {
                    towerBuilder.addUpgradeView(each, location: viewLocation, gameScene: self)
                }
                return
            }
        }
        
        
    }

    
    
    //in the SpriteKit game framework the update method is the main game loop
    override func update(currentTime: CFTimeInterval) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        if gameOver {
            return
        }

        appDelegate.gameScene!.deltaTime = CGFloat(currentTime) - appDelegate.gameScene!.gameTime
        appDelegate.gameScene!.totalTime += appDelegate.gameScene!.deltaTime
        appDelegate.gameScene!.gameTime = CGFloat(currentTime)
        
        
        
        giveResources(appDelegate.gameScene!.totalTime)
        
        //We can't put a appDelegate in the constructor because GameScene is in AppDelegate
       
        
        appDelegate.updateMyLabel()
        
        // Get enemies and add them to list and scene
        let newEnemy = enemyFactory.getNextEnemy()
        if newEnemy != nil {
           let randNum = arc4random_uniform(UInt32(spawnLocs.count))
            //going to set the location to one of the enemy spawn spots
            let spawnLocation = spawnLocs[Int(randNum)]
                newEnemy?.sprite.position = spawnLocation
                nextWaveDelay = false
                appDelegate.gameScene!.enemies.append(newEnemy!)
                appDelegate.gameState.enemies.append(newEnemy!)
                appDelegate.gameScene!.addChild(newEnemy!.sprite)
            
            
           
        }
        // Trigger attack/defend strategies for each tower
        for (var i = 0; i < appDelegate.gameScene!.towers.count; i++)
        {
            let t = appDelegate.gameScene!.towers[i]
            t.TriggerAttack()
            t.TriggerDefend()
            
            if t.CheckIfDead(){
                t.sprite.removeFromParent()
                
                appDelegate.gameScene!.towers.removeAtIndex(i)
                i -= 1
            }
        }
        for (var i = 0; i < appDelegate.gameScene!.enemies.count; i++)
        {
            let e = appDelegate.gameScene!.enemies[i]
            e.TriggerAttack()
            e.moveMore()
            e.UpdateLabel()
  
            if e.CheckIfDead(){
                e.sprite.removeFromParent()
                
                //add gold to user when enemys die
                appDelegate.user.gold += e.reward
                appDelegate.gameState.enemies.removeAtIndex(i)
                
                appDelegate.gameScene!.enemies.removeAtIndex(i)
                i -= 1
            }
        }
        
        for (var i = 0; i < appDelegate.gameScene!.items.count; i++) {
            let item = appDelegate.gameScene!.items[i]
            if (item.destroyThis) {
                item.destroy()
                appDelegate.gameScene!.items.removeAtIndex(i)
                i -= 1;
            }
            else {
                item.update()
            }
        }

        // Calculate player y offset
        if bossNode?.sprite.position.y > 200.0 {
        for t in appDelegate.gameScene!.towers{
            t.sprite.position = CGPoint(x: 0.0, y: -((bossNode!.sprite.position.y - 200.0)/10))
        }
        for e in appDelegate.gameScene!.enemies {
            e.sprite.position = CGPoint(x: 0.0, y: -((bossNode!.sprite.position.y - 200.0)/4))
        }
        
            background!.position = CGPoint(x: 0.0, y: -(bossNode!.sprite.position.y - 200.0))
        }
        
        if appDelegate.gameScene!.enemies.isEmpty && appDelegate.user.gold < 100 && appDelegate.gameScene!.towers.isEmpty {
            
            endGame()
            appDelegate.resetUser()
        } else if appDelegate.gameScene!.enemies.isEmpty && !appDelegate.gameScene!.towers.isEmpty && !nextWaveDelay{
           nextWave()
        } else if !appDelegate.gameScene!.enemies.isEmpty && appDelegate.gameScene!.towers.isEmpty && appDelegate.user.gold < 100{
            appDelegate.resetUser()
            endGame()

        }
        
    }
    //function to give resources to the play based on how long they defend the tower
    func giveResources(time: CGFloat)
    {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.user.o2 += Int(time)
        appDelegate.user.metal += Int(time)
        appDelegate.user.fuel += Int(time)
    }
    
    //function to add xp to the player currently based on the damage of the strategy of the enemy
    func giveXp(enmey: EnemyBase)
    {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.user.xp += Int(enmey.attack.damage * 5)

    }
    
    // Handles the wave progression
    func nextWave(){

        nextWaveDelay = true
        appDelegate?.gameState.wave++
        
        //Set up the label
        let gameOverLabel = SKLabelNode(fontNamed: "Square")
        gameOverLabel.text = "WAVE COMPLETED"
        gameOverLabel.fontSize = 45
        gameOverLabel.position = CGPoint(x: self.scene!.size.width/2, y: self.scene!.size.height/2)
        gameOverLabel.zPosition = 1000
        
        self.addChild(gameOverLabel)
        let removeNodeAction = SKAction.removeFromParent()
        let waiTime : NSTimeInterval = 1.8
        let waitAction = SKAction.waitForDuration(waiTime)
        let RemoveSequence = SKAction.sequence([waitAction, removeNodeAction])
        gameOverLabel.runAction(RemoveSequence)
        enemyFactory.nextWave()

    }

    //this method is called whenever two physicsBodies contact.  The appropriate logic is called depending which objects did hte contacting.
    func didBeginContact(contact: SKPhysicsContact) {
        // Bitiwse OR the bodies' categories to find out what kind of contact we have
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        //this first case is executed when a tower bullet hits a enemy.
        case CategoryMask.Enemy | CategoryMask.TowerBullet:
            
            for e in appDelegate!.gameScene!.enemies{
                if e.sprite == contact.bodyA.node{
                    let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage
                    giveXp(e)
                    e.UpdateLabel()
                    contactTest.destroy()
                  appDelegate!.conductor.hitEnemyPlaySound(0.0125, e: e)
                    contact.bodyB.node?.removeFromParent()
                } else if e.sprite == contact.bodyB.node{
                    let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage
                    giveXp(e)
                    e.UpdateLabel()
                    contactTest.destroy()
                 appDelegate!.conductor.hitEnemyPlaySound(0.02, e: e)
                    contact.bodyA.node?.removeFromParent()
                }
            }
         //this case is if an enemy bullet has hit a tower.
        case CategoryMask.Tower | CategoryMask.EnemyBullet:
            
            for t in appDelegate!.gameScene!.towers{
                
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
    func toPlanetPicker()
    {
        self.viewController.toPlanetPicker()
    }
    func toSideScroll()
    {
        self.viewController.toSideScroll()
    }
    func endGame() {

    gameOver = true
        
    self.viewController.gameOver()    
        
    /*let reveal = SKTransition.fadeWithDuration(0.05)
    let endGameScene = EndGameScene(size: self.size)
    self.view!.presentScene(endGameScene, transition: reveal)*/
    }
}