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
   
    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    //making all of these static allows us to not have to pass them around method calls
    static var towers : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    static var items : [Item] = [Item]()
    //static var boss : [EnemyBase] = [EnemyBase]()
    static var gameTime : CGFloat = 0
    static var deltaTime : CGFloat = 0
    static var scene : GameScene? = nil
    //bool actions
    var mainHudIsUP = false
    var mainBuild = false
    var odd : Bool = false // This is just for switching between tower types until we get tower building fully functional
    var towerHardLimit : Int = 20
    static var totalTime : CGFloat = 0.0
    
    override func didMoveToView(view: SKView) {

        gameOver = false
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 1024/2, y: 768/2)
        cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(cameraNode)
        self.camera = cameraNode

        background.zPosition = ZPosition.background;


        print(scene?.size.width, scene?.size.height)

        waveLabel.fontSize = 65
        waveLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height - 60)
        waveLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        
        enemiesLabel.fontSize = 45
        enemiesLabel.position = CGPoint(x: CGRectGetMaxX(self.frame) - 20, y: CGRectGetMaxY(self.frame) - 60)
        enemiesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right

        myLabel.text = "DEFFEND!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 10, y:CGRectGetMaxY(self.frame) - 60);
        myLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        xpLabel.fontSize = 45;
        xpLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 10, y:CGRectGetMaxY(self.frame) - 120);
        xpLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        o2Label.fontSize = 45;
        o2Label.position = CGPoint(x:CGRectGetMinX(self.frame) + 220, y:CGRectGetMaxY(self.frame) - 60);
        o2Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        o2Label.text = "o2 lael"
        metalLabel.fontSize = 45;
        metalLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 220, y:CGRectGetMaxY(self.frame) - 120);
        metalLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        metalLabel.text = "metal label"
        self.addChild(waveLabel)
        self.addChild(o2Label )
       self.addChild(metalLabel)
        waveLabel.fontColor = UIColor(red: 1.0, green: 0.0 / 255, blue: 0.0 / 255, alpha: 1.0)
        waveLabel.zPosition = ZPosition.bullet
        
        self.addChild(enemiesLabel)
        enemiesLabel.zPosition = ZPosition.bullet
        
        self.addChild(myLabel)
        myLabel.zPosition = ZPosition.bullet
        
        self.addChild(xpLabel)
        xpLabel.zPosition = ZPosition.bullet
        
        self.addChild(background)

        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        self.view!.multipleTouchEnabled = true
        
    }
    
    //helper to make towers
    func addTower(location: CGPoint, touch: UITouch)
    {

        let touchLocation = touch.locationInView(self.view!)
        let tower : TowerBase = towerBuilder.BuildBaseTower(location)
        
        if (addGold(-100)) {
            GameScene.towers.append(tower)


            towerBuilder.addUpgradeView(tower, location: touchLocation, gameScene: self)

        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches.count > 1)
            {
        let oneT = desTouches[0].locationInNode(self).x - desTouches[1].locationInNode(self).x
        let twoT = desTouches[0].locationInNode(self).y - desTouches[1].locationInNode(self).y
        touchScale  = sqrt(oneT * oneT + twoT * twoT)
                
        if !scaleSet{
            scaleScale = touchScale
            scaleSet = true
        }
    }
        if !lastTouchSet
        {
            lastTouch = touches.first!
            lastTouchSet = true
        }
        var counter = 0
        for touch in touches {
            desTouches.append(touch)
            counter++
        }
    }
    //some class level variables to keep track of the last touch locations
    var touchScale : CGFloat = 0.0
    var scaleScale : CGFloat = 0.0
    var scaleSet = false
    var lastTouch : UITouch = UITouch()
    var lastTouchSet = false
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
        if (touches.count > 1)
        {
       
//            let oneT = desTouches[0].locationInNode(self).x - desTouches[1].locationInNode(self).x
//            let twoT = desTouches[0].locationInNode(self).y - desTouches[1].locationInNode(self).y
//            touchScale  = sqrt(oneT * oneT + twoT * twoT)
//        
//            touchScale = (touchScale / scaleScale)
//            
//            
//            if (touchScale < 4 && touchScale > 0)
//            {
//                print("scale \(touchScale)")
//                let xScale = self.cameraNode.xScale
//                print("current scale \(xScale)")
//                self.cameraNode.setScale(touchScale)
//            }
//            else
//            {
//                self.cameraNode.setScale(scaleScale)
//            }
//            scaleScale = touchScale
        }
        else
        {
            
            let x = lastTouch.locationInView(self.view).x
            let lastX = touches.first!.locationInView(self.view).x
            let y = lastTouch.locationInView(self.view).y
            let lastY = touches.first!.locationInView(self.view).y
            var newX : CGFloat = 0.0
            var newY : CGFloat = 0.0
            if (lastX - x != 0)
            { newX = (x - lastX )/20.0}
            else
            {
                newX = 0
            }
            if (lastY - y != 0)
            {
                
               newY = (y - lastY )/20
            }
            else
            {
                newY = 0
            }
            self.cameraNode.position.x -= newX
            self.cameraNode.position.y += newY
            print("should be moving: \(newX), \(newX)")
            
        }
        
    
    }
    
    //
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        desTouches.removeAll()
        /* Called when a touch begins */
        let touch = touches.first
        
        let location = touch!.locationInNode(self)
       let viewLocation = touch!.locationInView(self.view!)
        lastTouch = touches.first!
        
        //this is just a thing to tringer conduvtor stuff.
        if touches.count > 2
        {
            
            appDelegate!.conductor.recursiveNotesRandom(5, maxLength: 2.0)

        }
        if touch?.tapCount > 1 && !mainBuild
        //if touches.count > 1 && !mainBuild
        {
            let mainTower = towerBuilder.BuildMainTower(location)
            GameScene.towers.append(mainTower)
            mainBuild = true
            return
        }
        else if touch?.tapCount > 1
        {
        //if we found a tower open menu else add tower
        if GameScene.towers.count <= towerHardLimit
        {
            
            addTower(location, touch: touch!)
            return
        }
        }
        for each in GameScene.towers
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

        if gameOver {
            return
        }

        GameScene.deltaTime = CGFloat(currentTime) - GameScene.gameTime
        GameScene.totalTime += GameScene.deltaTime
        GameScene.gameTime = CGFloat(currentTime)
        
        //We can't put a appDelegate in the constructor because GameScene is in AppDelegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.updateMyLabel()
        
        // Get enemies and add them to list and scene
        let newEnemy = enemyFactory.getNextEnemy()
        if newEnemy != nil {
            nextWaveDelay = false
            GameScene.enemies.append(newEnemy!)
            appDelegate.gameState.enemies.append(newEnemy!)
            GameScene.scene?.addChild(newEnemy!.sprite)
        }
        // Trigger attack/defend strategies for each tower
        for (var i = 0; i < GameScene.towers.count; i++)
        {
            let t = GameScene.towers[i]
            t.TriggerAttack()
            t.TriggerDefend()
            
            if t.CheckIfDead(){
                t.sprite.removeFromParent()
                
                GameScene.towers.removeAtIndex(i)
                i -= 1
            }
        }
        for (var i = 0; i < GameScene.enemies.count; i++)
        {
            let e = GameScene.enemies[i]
            e.TriggerAttack()
            e.moveMore()
            e.UpdateLabel()
  
            if e.CheckIfDead(){
                e.sprite.removeFromParent()
                
                //add gold to user when enemys die
                appDelegate.user.gold += e.reward
                appDelegate.gameState.enemies.removeAtIndex(i)
                
                GameScene.enemies.removeAtIndex(i)
                i -= 1
            }
        }
        
        for (var i = 0; i < GameScene.items.count; i++) {
            let item = GameScene.items[i]
            if (item.destroyThis) {
                item.destroy()
                GameScene.items.removeAtIndex(i)
                i -= 1;
            }
            else {
                item.update()
            }
        }

        // Calculate player y offset
        if bossNode?.sprite.position.y > 200.0 {
        for t in GameScene.towers{
            t.sprite.position = CGPoint(x: 0.0, y: -((bossNode!.sprite.position.y - 200.0)/10))
        }
        for e in GameScene.enemies {
            e.sprite.position = CGPoint(x: 0.0, y: -((bossNode!.sprite.position.y - 200.0)/4))
        }
        
            background!.position = CGPoint(x: 0.0, y: -(bossNode!.sprite.position.y - 200.0))
        }
        
        if GameScene.enemies.isEmpty && appDelegate.user.gold < 100 && GameScene.towers.isEmpty {
            
            endGame()
            appDelegate.resetUser()
        } else if GameScene.enemies.isEmpty && !GameScene.towers.isEmpty && !nextWaveDelay{
           nextWave()
        } else if !GameScene.enemies.isEmpty && GameScene.towers.isEmpty && appDelegate.user.gold < 100{
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
            
            for e in GameScene.enemies{
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
            
            for t in GameScene.towers{
                
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
    func endGame() {

    gameOver = true
        
    self.viewController.gameOver()    
        
    /*let reveal = SKTransition.fadeWithDuration(0.05)
    let endGameScene = EndGameScene(size: self.size)
    self.view!.presentScene(endGameScene, transition: reveal)*/
    }
}