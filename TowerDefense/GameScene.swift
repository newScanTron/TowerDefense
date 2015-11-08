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

    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    let tower = TowerBuilder()
    static var towers : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    static var gameTime : Float = 0
    
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "beach")
        background.position = CGPoint(x: 500, y: 200)
        background.zPosition = -2;
        
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
        addEnemy()
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
        sprite.physicsBody?.categoryBitMask = PhysicsCategory.All
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.All
        sprite.physicsBody?.contactTestBitMask = PhysicsCategory.All
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
                let upgradeView = UpgradeView(x: (touch?.locationInView(nil).x)!, y: (touch?.locationInView(nil).y)!)
                
                self.view?.addSubview(upgradeView.GetView())	
            }
            else if GameScene.towers.count <= towerTotal
            {
                addTower(location)
            }

        //this calls and displays the upgrade view.
        //upgradeView.SetViewLocation((touch?.locationInView(nil).x)!, y: (touch?.locationInView(nil).y)!)
        
        //self.view?.addSubview(upgradeView.GetView())

            for e in GameScene.enemies {
                e.TriggerAttack(e)
                //            e.TriggerMovement(currentTime);
                
            }
        }
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        GameScene.gameTime = Float(currentTime)

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
    func addEnemy(){
        
        if(enemyCount < 11){
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
        
        /*if (GameScene.enemies.count <= 10)
        //create and add enemy
        {
            let enemy = enemyFactory.CreateEnemy(self)
            self.addChild(enemy.sprite)
            GameScene.enemies.append(enemy)
        }*/
        

        //check number of baddies and create more
//        if GameScene.enemies.count <= 5
//        {
//            addEnemy()
//        }
    }
    class func getClosestEnemy(point : CGPoint) -> EnemyBase? {
        
        var closestEnemy : EnemyBase?
        var closestDistance : Float = 999999
        var tempDistance : Float

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
        var closestDistance : Float = 999999
        var tempDistance : Float
        
        for t in towers {
            tempDistance = getDistance(point,to: t.sprite.position)
            if (tempDistance < closestDistance) {
                closestDistance = tempDistance
                closestTower = t;
            }
        }
        
        return closestTower;
    }
    
    class func getDistance(from : CGPoint, to : CGPoint) -> Float {
        
        return Float(sqrt(pow(from.x-to.x,2) + pow(from.y-to.y,2)))
    }
}
