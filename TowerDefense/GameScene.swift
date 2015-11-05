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
    

    //Enemy Factory
    var enemyFactory = EnemyFactory()
    var towerBuilder = TowerBuilder()
    static var towers : [TowerBase] =  [TowerBase]() // Stores all towers in level in order to call their strategies each frame
    static var enemies : [EnemyBase] = [EnemyBase]() // Stores all towers in level in order to call their strategies each frame
    static var gameTime : Float = 0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        
        myLabel.text = "DEFFEND!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
       
        
    
        
        
        
    }

    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        myLabel.removeFromParent()
        let touch = touches.first
        let location = touch!.locationInNode(self)
        
        //create and add tower
        let tower = towerBuilder.BuildTower(location)
        
        
        //create and add enemy
        let enemy = enemyFactory.CreateEnemy(self)
        self.addChild(enemy.sprite)
        GameScene.enemies.append(enemy)
        enemy.Move()
        
    
        for each in GameScene.towers
        {
            if each.sprite.containsPoint(location)
            {
                let upgradeView = UpgradeView(x: (touch?.locationInView(nil).x)!, y: (touch?.locationInView(nil).y)!)
                
                self.view?.addSubview(upgradeView.GetView())
            }
        }
           
            
            
            //this calls and displays the upgrade view.
           // upgradeView.SetViewLocation()
        
        
       
            //need something to make the updrageView disapear if we are not interacting with it.
            GameScene.towers.append(tower)
            self.addChild(tower.sprite)
            
        
       
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        GameScene.gameTime = Float(currentTime)
        
        // Trigger attack/defend strategies for each tower
        for t in GameScene.towers {
            t.TriggerAttack();
            t.TriggerDefend();
        }
        
//        for e in GameScene.enemies {
//            e.TriggerAttack(currentTime);
//            e.TriggerMovement(currentTime);
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
