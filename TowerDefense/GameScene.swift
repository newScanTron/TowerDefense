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


class GameScene: SKScene , SKPhysicsContactDelegate{
    
    
    let satellite = SKSpriteNode(imageNamed: "Sat2")
    let myLabel = SKLabelNode(fontNamed:"Verdana")
    let towerTotal = 5
    let cero = 0
    var enemyCount = 0
    let enemyMin = 11
    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    let tower = TowerBuilder()
    static var towers : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    static var gameTime : CGFloat = 0
    static var scene : GameScene? = nil
    
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "beach")
        background.position = CGPoint(x: 500, y: 200)
        background.zPosition = ZPosition.background;
        
        //sprite to be the edge/base
        let wall = SKSpriteNode(imageNamed: "Castle_wall")
         buildWall(wall)				
        
        self.addChild(background)
        self.addChild(wall)
        /* Setup your scene here */
        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        
        myLabel.text = "DEFFEND!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        
//        for var i = 0; i < 10; i++
//        {
//            addEnemy()
//        }
        self.addChild(myLabel)
        
        initializeEnemyArray()

        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
            SKAction.runBlock(addEnemy),
            SKAction.waitForDuration(1.5)
            ])
        ))
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
        //create and add tower
        let tower = towerBuilder.BuildTower(location)
        //need something to make the updrageView disapear if we are not interacting with it.
        GameScene.towers.append(tower)
        self.addChild(tower.sprite)
    
    }
    
    //
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        myLabel.removeFromParent()
        let touch = touches.first
        let location = touch!.locationInNode(self)
        
        //check if any and build one with first touch
        if GameScene.towers.count <= cero
        {
            addTower(location)
        }
    
        for each in GameScene.towers
        {
            if each.sprite.containsPoint(location)
            {
                var upgradeView = AttackSetRange(x: (touch?.locationInView(nil).x)!, y: (touch?.locationInView(nil).y)!, tower: each)
                //getting the chain set up and giving it a location passing a reff in the form of an inout paramaterss
                setUpChain(&upgradeView, x: (touch?.locationInView(nil).x)!, y: (touch?.locationInView(nil).y)!)
                //The Game scene is only responsible for adding the first node to itself.  Each node knows how to display their information an
                self.view?.addSubview(upgradeView.GetView())
            }
            else if GameScene.towers.count <= towerTotal
            {
                addTower(location)
            }

            
        }
    }
    override func update(currentTime: CFTimeInterval) {
        

        
        /* Called before each frame is rendered */
        GameScene.gameTime = CGFloat(currentTime)

        // Trigger attack/defend strategies for each tower
        for t in GameScene.towers {
            t.TriggerAttack();
            t.TriggerDefend();
        }
        //for e in GameScene.enemies 
        for var i = 0; i < GameScene.enemies.count ; i++
        {
            if (GameScene.enemies[i].sprite.position.x < -10){
                GameScene.enemies[i].sprite.removeFromParent()
                //GameScene.enemies.removeAtIndex(i)
            }
        }
    }
    func initializeEnemyArray(){
        for var i = 0; i < 10 ; i++
        {
            let enemy = enemyFactory.CreateEnemy(self)
            GameScene.enemies.append(enemy)
            if(i == 9){
                let enemy = enemyFactory.CreateEnemyBoss(self)
                GameScene.enemies.append(enemy)

            }
        }
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
        
        
        
    }
    func addEnemy(){
        
        if(GameScene.enemies.count < enemyMin){
            self.addChild(GameScene.enemies[enemyCount].sprite)
            enemyCount++
            for var i = 0; i < enemyCount ; i++
            {
                if (GameScene.enemies[i].sprite.position.x < -10){
                    GameScene.enemies[i].sprite.removeFromParent()
                    //enemyCount--
                }
            }

        }
        

    }
    class func getClosestEnemy(point : CGPoint) -> EnemyBase? {
        
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
        
        return closestEnemy;
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
    
    
    class func getDistance(from : CGPoint, to : CGPoint) -> CGFloat {
        
        return CGFloat(sqrt(pow(from.x-to.x,2) + pow(from.y-to.y,2)))
    }
}
