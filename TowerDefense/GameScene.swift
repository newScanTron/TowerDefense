//
//  GameScene.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/27/15.
//  Copyright (c) 2015 Chris Murphy. All rights reserved.
//

import SpriteKit
import UIKit


class GameScene: SKScene , SKPhysicsContactDelegate{
     let satellite = SKSpriteNode(imageNamed: "Sat2")
     let myLabel = SKLabelNode(fontNamed:"Verdana")
    let viewTime = UIView(frame: CGRectMake(0, 0, 200, 200))
    var b = UIButton(frame: CGRectMake(0,0, 200,10))
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self

        myLabel.text = "DEFFEND!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        
        b.setTitle("yeah", forState: UIControlState.Normal)
        b.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        b.addTarget(self, action: "buttonTime", forControlEvents: UIControlEvents.TouchUpInside)
        viewTime.addSubview(b)
        
        self.view?.addSubview(viewTime)
    }
    func buttonTime()
    {
        b.setTitle("nope", forState: UIControlState.Normal)
    }
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
            myLabel.removeFromParent()
        let touch = touches.first
        
        
            let location = touch!.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed: "Sat2")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
        let vect = CGVector(dx: CGFloat(-450), dy: CGFloat(0))
            sprite.physicsBody = SKPhysicsBody()
        sprite.physicsBody?.collisionBitMask = PhysicsCategory.Tower
        sprite.physicsBody?.dynamic = true
        
            
            //let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            //sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
         sprite.physicsBody?.applyImpulse(vect)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
