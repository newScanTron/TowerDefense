//
//  BossMoveStrat.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/4/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class BossMoveStrat: EnemyMoveStrat {
    
    var lastMove : CGFloat = 0
    var bossNode : EnemyBase! = nil
    var target : [TowerBase] = [TowerBase]()
    
    override func Move(nodeToMove : EnemyBase){

        let offSet : CGFloat = 150
        bossNode = nodeToMove
        if (parent != nil){
            target = GameScene.getTowersInRange(parent!.sprite.position, range: 150)
        }
        if bossNode.sprite.position.x >= GameScene.scene!.size.width - offSet{
            outOfBounds()
        }
        else if bossNode.sprite.position.x <= 0 + offSet{
            outOfBounds()
        }
        if bossNode.sprite.position.y >= GameScene.scene!.size.height - offSet{
            outOfBounds()
        }
        else if bossNode.sprite.position.y <= 0 + offSet{
            outOfBounds()
        }
        
        if nodeToMove.sprite.position.x < GameScene.scene!.size.width - offSet && nodeToMove.sprite.position.x > 0 + offSet && nodeToMove.sprite.position.y < GameScene.scene!.size.height - offSet && nodeToMove.sprite.position.y > 0 + offSet {
            for t in target{
                nodeToMove.sprite.physicsBody?.applyImpulse(getVector(parent!.sprite.position, to: t.sprite.position, speed: 2))
            }
            if target.isEmpty{
                parent!.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYRand()))
            }
        }
        /*else{
            outOfBounds()
        }*/
        
        //Changes all enemy move strategies to Swarm Strategy ... except da boss of course
        if nodeToMove.sprite.position.x < 1000{
            for e in GameScene.enemies{
                if e.sprite.name != "Boss"
                {
                    e.setMoveStrategy(EnemySwarmStrat())
                }
            }
        }
    }

    func outOfBounds(){
        let centerPoint = CGPointMake(GameScene.scene!.size.width/2, GameScene.scene!.size.height/2)
        let center = getVector(bossNode.sprite.position, to: centerPoint, speed: 3)
        if (parent != nil) {
            parent!.sprite.physicsBody?.applyImpulse(center)
        }
        
    }
    func upwardSpiral(){
        bossNode.sprite.physicsBody?.linearDamping = 0
        bossNode.sprite.physicsBody?.applyImpulse(CGVectorMake(getImpulseXRand(), getImpulseYPos()))
    }
    func downwardSpiral(){
        
    }
}
class EnemySwarmStrat : EnemyMoveStrat{
    
    var lastMove : CGFloat = 0
    
    override func Move(nodeToMove : EnemyBase) {

        
        
        for e in GameScene.enemies{
            
            if e.sprite.name == "Boss"{
                
                if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(250){
                    nodeToMove.sprite.physicsBody?.linearDamping = 0.75
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: e.sprite.position, speed: 9.0))
                }
                else if GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) > CGFloat(75) && GameScene.getDistance(nodeToMove.sprite.position, to: e.sprite.position) < 250 {
                    nodeToMove.sprite.physicsBody?.linearDamping = 0.5
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: e.sprite.position, speed: 8.0))
                }
                else {
                    nodeToMove.sprite.physicsBody?.linearDamping = 0
                    nodeToMove.sprite.physicsBody?.applyImpulse(getVector(nodeToMove.sprite.position, to: e.sprite.position, speed: 20.0))
                }
            }
        }
    }
}