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

class GameScene: SKScene , SKPhysicsContactDelegate{

    var viewController: GameViewController!
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    //let satellite = SKSpriteNode(imageNamed: "Sat2")
    let myLabel = SKLabelNode(fontNamed:"Square")
    let xpLabel = SKLabelNode(fontNamed:"Square")
    let gameOverLabel = SKLabelNode(fontNamed: "Square")
    //var background : SKSpriteNode? = nil
    let towerTotal = 20
    let bossNode: EnemyBase? = nil
    let cero = 0
    var gameOver : Bool = false
    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    let tower = TowerBuilder()
    //making all of these static allows us to not have to pass them around method calls
    static var towers : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    static var items : [Item] = [Item]()
    static var boss : [EnemyBase] = [EnemyBase]()
    static var gameTime : CGFloat = 0
    static var deltaTime : CGFloat = 0
    static var scene : GameScene? = nil


    var odd : Bool = false // This is just for switching between tower types until we get tower building fully functional
    var towerHardLimit : Int = 20

    override func didMoveToView(view: SKView) {

        gameOver = false
        let background = SKSpriteNode(imageNamed: "beach")
        background.position = CGPoint(x: 500, y: 200)
        

        background.zPosition = ZPosition.background;


        print(scene?.size.width, scene?.size.height)


        myLabel.text = "DEFFEND!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 10, y:CGRectGetMaxY(self.frame) - 60);
        myLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        gameOverLabel.text = "You Won"
        gameOverLabel.fontSize = 45
        gameOverLabel.position = CGPoint(x: self.scene!.size.width/2, y: self.scene!.size.height/2)

        
        xpLabel.fontSize = 45;
        xpLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 10, y:CGRectGetMaxY(self.frame) - 120);
        xpLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        self.addChild(myLabel)
        myLabel.zPosition = ZPosition.bullet
        
        self.addChild(xpLabel)
        xpLabel.zPosition = ZPosition.bullet

        
        //sprite to be the edge/base
       // let wall = SKSpriteNode(imageNamed: "Castle_wall")
        //buildWall(wall)
        
        self.addChild(background)
        //self.addChild(wall)
        /* Setup your scene here */
        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        
    }
    func buildWall(sprite: SKSpriteNode)
    {
        sprite.position = CGPoint(x: -125, y: 325)
        sprite.yScale = 1.5
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        sprite.physicsBody?.categoryBitMask = CategoryMask.All
        sprite.physicsBody?.collisionBitMask = CollisionMask.All
        sprite.physicsBody?.contactTestBitMask = ContactMask.All
        sprite.physicsBody?.dynamic = false
        sprite.zPosition = ZPosition.wall
        
    }
    
    //helper to make towers
    func addTower(location: CGPoint)
    {
        
       
        
//        var tower : TowerBase?
//        
//        //create and add tower
//        if (odd) {
//            tower = towerBuilder.BuildPulseTower(location)
//        }
//        else {
//            tower = towerBuilder.BuildTower(location)
//        }
//        if (tower != nil) {
//            odd = !odd
//            GameScene.towers.append(tower!)
//            self.addChild(tower!.sprite)
//        }
        
        let tower : TowerBase = towerBuilder.BuildBaseTower(location)
        
        if (GameScene.addGold(-100)) {
            GameScene.towers.append(tower)
            self.addChild(tower.sprite)
            addUpgradeView(tower, location: location, gameScene: self)
        }
        
    }
    
    
    //
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let touch = touches.first
        let location = touch!.locationInNode(self)
        
       //check each tower and see if the touch location was the same as the tower
        for each in GameScene.towers
        {
            if each.sprite.containsPoint(location)
            {
                addUpgradeView(each, location: touch!.locationInView(nil), gameScene: self)
                return
            }
        }
        //if we found a tower open menu else add tower
        if GameScene.towers.count <= towerHardLimit
        {
            addTower(location)
        }
    }

    
    
    //in the SpriteKit game framework the update method is the main game loop
    override func update(currentTime: CFTimeInterval) {
      
        if gameOver{
            return
        }
        /* Called before each frame is rendered */
        GameScene.deltaTime = CGFloat(currentTime) - GameScene.gameTime
        GameScene.gameTime = CGFloat(currentTime)
        //We can't put a appDelegate in the constructor because GameScene is in AppDelegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.updateMyLabel()
        
        // Get enemies and add them to list and scene
        let newEnemy = enemyFactory.getNextEnemy()
        if newEnemy != nil {
            GameScene.enemies.append(newEnemy!)
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
        
            //background!.position = CGPoint(x: 0.0, y: -(bossNode!.sprite.position.y - 200.0))
        }
        
        if GameScene.enemies.isEmpty && appDelegate.gameState.gold < 100 && GameScene.towers.isEmpty {
            //endGame()
        } else if GameScene.enemies.isEmpty && !GameScene.towers.isEmpty {
            endGame()
        } else if !GameScene.enemies.isEmpty && GameScene.towers.isEmpty{
            //endGame()

        }
    }

    //function to add xp to the player currently based on the damage of the strategy of the enemy
    func giveXp(enmey: EnemyBase)
    {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.user.xp += Int(enmey.attack.damage * 5)
        
    }
    

    //func that will set up the chain of reponsibility for updating
    func setUpChain(inout node: AttackSetRange, x: CGFloat , y: CGFloat)
    {
        //initialize the nodes of the chain
        let setDamageNode = AttackSetDamage(x: x, y: y)
        let fireDeleyNode = SetFireDelay(x: x, y: y)
        let setSpeed = SetSpeed(x: x, y: y)
        let deffenseSetRange = DeffenseSetRange(x: x, y: y)
        let deffenseSetAmount = DeffenseSetAmount(x: x, y: y)
        
        //set all the nodes to the seccuessor
        node.setNextNode(setDamageNode)
        setDamageNode.setNextNode(fireDeleyNode)
        fireDeleyNode.setNextNode(setSpeed)
        setSpeed.setNextNode(deffenseSetRange)


        deffenseSetRange.setNextNode(deffenseSetAmount)
        //deffenseSetAmount is not set to have a node following it so it

    }


    class func getClosestEnemy(point : CGPoint, range : CGFloat) -> EnemyBase? {
        
        var closestEnemy : EnemyBase?
        var closestDistance : CGFloat = 999999
        var tempDistance : CGFloat
        
        for e in enemies {
            tempDistance = getDistance(point,to: e.sprite.position)
            if (tempDistance < closestDistance) {
                closestDistance = tempDistance
                closestEnemy = e;
            }
        }
        if (closestDistance < range) {
            return closestEnemy;
        }
        else {
            return nil
        }
    }
    
    class func getTowersInRange(point : CGPoint, range : CGFloat) -> [TowerBase] {
        var inRange : [TowerBase] = [TowerBase]()
        for t in towers {
            if (getDistance(point,to:t.sprite.position) < range) {
                inRange.append(t);
            }
        }
        return inRange
    }
    
    class func getEnemiesInRange(point : CGPoint, range : CGFloat) -> [EnemyBase] {
        var inRange : [EnemyBase] = [EnemyBase]()
        for e in enemies {
            if (getDistance(point,to:e.sprite.position) < range) {
                inRange.append(e);
            }
        }
        return inRange
    }
    
    class func getClosestTower(point : CGPoint) -> TowerBase? {
        
        var closestTower : TowerBase?
        var closestDistance : CGFloat = 999999
        var tempDistance : CGFloat
        
        for t in towers {
            tempDistance = getDistance(point,to: t.sprite.position)
            if (tempDistance < closestDistance) {
                closestDistance = tempDistance
                closestTower = t;
            }
        }
        
        return closestTower;
    }
    
    class func addGold(amount : Int) -> Bool{
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        if (appDelegate.user.gold + amount >= 0) {
            // User has enough gold, return true
            appDelegate.user.gold += amount
            return true
        }
        // User does not have enough gold, return false
        return false
    }
    
    
    class func getDistance(from : CGPoint, to : CGPoint) -> CGFloat {
        
        return CGFloat(sqrt(pow(from.x-to.x,2) + pow(from.y-to.y,2)))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // Bitiwse OR the bodies' categories to find out what kind of contact we have
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        
        case CategoryMask.Enemy | CategoryMask.TowerBullet:
            
            for e in GameScene.enemies{
                if e.sprite == contact.bodyA.node{
                    let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage

                    giveXp(e)
                    e.UpdateLabel()


                    contactTest.destroy()


                    contact.bodyB.node?.removeFromParent()
                } else if e.sprite == contact.bodyB.node{
                    let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    e.health -= contactTest.damage

                    giveXp(e)

                    e.UpdateLabel()

                    contactTest.destroy()

                    contact.bodyA.node?.removeFromParent()
                }
            }
            
        case CategoryMask.Tower | CategoryMask.EnemyBullet:
            
            for t in GameScene.towers{
                
                if t.sprite == contact.bodyA.node{
                    let contactTest : Bullet = contact.bodyB.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(contactTest.damage)
                    //t.UpdateLabel()
                    contactTest.destroy()
                    contact.bodyB.node?.removeFromParent()
                } else if t.sprite == contact.bodyB.node{
                    let contactTest : Bullet = contact.bodyA.node?.userData?["object"] as! Bullet
                    t.health -= CGFloat(contactTest.damage)
                    //t.UpdateLabel()
                    contactTest.destroy()
                    contact.bodyA.node?.removeFromParent()
                }
            }
            
        default:
            
            print("other collision: \(contactMask)")
        }
    }
    func endGame() {

    gameOver = true
        
    self.viewController.gameOver()    
        
    /*let reveal = SKTransition.fadeWithDuration(0.05)
    let endGameScene = EndGameScene(size: self.size)
    self.view!.presentScene(endGameScene, transition: reveal)*/
    }
}