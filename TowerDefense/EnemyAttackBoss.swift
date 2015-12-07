//
//  GruntAttack.swift
//  TowerDefense
//
//  Created by Tobias Kundig on 11/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyAttackBoss: EnemyAttackStrat{
    
    var lastFire : CGFloat = 0
    var circle : SKShapeNode? = nil
    var healingTarget = [EnemyBase]()
    let color = SKColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 10)
    var allHealthy = false
    var healthCount = 0
    
    override init(){}
    
    override func Die()  {
        circle?.removeFromParent()
        circle = nil
        for e in GameScene.enemies{
            e.isImmune = false
            e.sprite.physicsBody?.linearDamping = 0.0
            //e.setMoveStrategy(EnemyMoveBasic())
        }
        Explosion(_radius: 300, _damage: 200).trigger(parent!.sprite.position)
    }
    
    override func Attack(){
        
        healthCount = 0
        healingTarget = GameScene.getEnemiesInRange(parent!.sprite.position, range: 125)
        
        for e in GameScene.enemies {
            if e.name == "BossSprite" {

            }
            else if GameScene.getDistance(parent!.sprite.position, to: e.sprite.position) <= 150 {
                if e.health < e.maxHealth{
                    allHealthy = false
                    e.health += 10
                    healthCount++
                    e.UpdateLabel()
                }
                e.isImmune = true
            }
            else {
                e.isImmune = false
            }
        }
        if healthCount == 0{
            allHealthy = true
        }
        circle?.removeFromParent()
        circle = SKShapeNode(circleOfRadius: 125.0)
        
        circle?.position = parent!.sprite.position
        
        circle?.lineWidth = 0.0;
        
        // Color fades as pulse progresses
        if (allHealthy) {
            circle?.fillColor = SKColor(red: 1, green: 0, blue: 0, alpha: 0.3)
            circle?.strokeColor = SKColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        }
        else {
            circle?.fillColor = SKColor(red: 0, green: 1, blue: 0, alpha: 0.3)
            circle?.strokeColor = SKColor(red: 0, green: 1, blue: 0, alpha: 0.3)
        }
        circle?.glowWidth = 0.5;
        circle?.zPosition = ZPosition.enemy
        circle?.blendMode = SKBlendMode.Screen
        if(parent!.sprite.position.x < 1000){
            GameScene.scene?.addChild(circle!)
        }

        /*if (allHealthy){
            parent!.setAttackStrategy(GruntAttack())
        }*/
    
    }
}

class EnemyBossAOEDPS : EnemyAttackStrat {
    
    var lastFire : CGFloat = 0
    var beam : SKSpriteNode? = nil
    let towerTarget = [TowerBase]()
    let color = SKColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 15)
    
    override init() {}
    
    override func Attack() {
        
        parent!.range = 350
        
        if (GameScene.gameTime > lastFire + fireDelay) {
            
            lastFire = GameScene.gameTime
            if beam?.parent != nil {
                beam!.removeFromParent()
            }
            if (parent != nil) {

                let towerTarget = GameScene.getTowersInRange(parent!.sprite.position, range: parent!.range)
                
                let beamHeight = GameScene.getDistance(parent!.sprite.position, to: towerTarget.first!.sprite.position)

                beam = SKSpriteNode(color: color, size: CGSizeMake(5, 20))
                    
                    //SKShapeNode(rectOfSize: CGSize(width: 1, height: beamHeight))
                let offSetX = (parent!.sprite.position.x - towerTarget.first!.sprite.position.x)/2
                let offSetY = (parent!.sprite.position.y - towerTarget.first!.sprite.position.y)/2

                
                beam!.position = CGPointMake(parent!.sprite.position.x, parent!.sprite.position.y)

                beam!.zPosition = ZPosition.enemy
                
                rotateBeam(towerTarget.first!, beam: beam!)
                GameScene.scene?.addChild(beam!)

            }
        }
        for e in GameScene.enemies{
            if e.health < e.maxHealth{
                parent!.setAttackStrategy(EnemyAttackBoss())
            }
        }
    }
    
}
