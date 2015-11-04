//
//  EnemyBase.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/31/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit
class EnemyBase: Entity{
    //Some variables for health and speed and whatnot
    var health = 0
    let attackStrat = RangedAttack()
    var moveStrat = ConcreteMoveStrat1()
    var sprite: SKSpriteNode
    var scene: SKScene
    //initlizer.
    init(sprite: SKSpriteNode, scene: SKScene)
    {
       self.sprite = sprite
        self.scene = scene
        self.sprite.xScale = 0.25
        self.sprite.yScale = 0.25
        
        self.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)//create physics body for sprite
        self.sprite.physicsBody?.dynamic = true //sets sprite to dynamic (physics engine will not control movement)
        self.sprite.physicsBody?.categoryBitMask = PhysicsCategory.Enemy//sets category bitmask to monstercategory
        self.sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Tower //who to notify when contact listeners intersect, in this case projectiles
        self.sprite.physicsBody?.collisionBitMask = PhysicsCategory.Tower //dont bounce off of anything
        
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    func randomVect(min min: CGFloat, max: CGFloat) -> CGVector{
        return CGVector(dx: random() * (max - min) + min, dy: 0)
    }
    func setMoveStrategy()
    {
 
        //let string = moveStrat.getMoveStrat()
        
        moveStrat.Move(sprite, scene: scene)
        
    }
    func setAttackStrategy(){
        //Set attack strategy
        
        //attackStrat.Attack()
    }
    //move function conforming to the EnemyMoveStart
    func Move()
    {
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI/2), duration:0.125)
        
        sprite.runAction(SKAction.repeatAction(action, count: 1))
        
        //determine where to spawn the bison along the Y axis
        let actualY = random(min: sprite.size.height/2, max: scene.size.height - sprite.size.height/2)
        
        //Position the bison slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        sprite.position = CGPoint(x: scene.size.width + sprite.size.width/2, y:actualY)
        //determine speed of the monster
        sprite.physicsBody?.applyImpulse(randomVect(min: -50, max: -25))

        
    }
    //attck function conforming to the EnemyAttackStart
    func Attack(s: SKNode, t: SKNode)
    {
        //let enemyPoint = s.position
        //let t = CGPoint(x: -sprite.size.width/2, y: random())
        attackStrat.Attack(self, t: t, s: scene)
    }
    func getMoveStrat() -> EnemyMoveStrat
    {
        return moveStrat
    }
}