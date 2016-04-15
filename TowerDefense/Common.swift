//
//  Common.swift
//  TowerDefense
//
//  Created by Chris Murphy on 10/28/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

//project level variables are allowed in swift.  I feel like i should have been using this more.
var currentPlanet = Planet(size: CGFloat(2), position: CGPoint(x: 0, y: 0), color: SKColor.greenColor(), metal: 0, oxygen: 0, fuel: 0 )
var currentScene : SKScene = SKScene()
var gameScene = GameScene()
var sideScrollScene = SideScrolScene()

struct CategoryMask { // Assigns categories for use with CollisionMask and ContactMask. Should all only have one 1 digit.
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0b0001
    static let Enemy        : UInt32 = 0b0010
    static let EnemyBullet       : UInt32 = 0b00100
    static let TowerBullet       : UInt32 = 0b01000
    static let TowerShield       : UInt32 = 0b10000
}

struct CollisionMask { // Which categories should this object "collide" with, i.e. interact with physically. Match with categories above.
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0b0000 // Towers only collide with other Towers and Enemies
    static let Enemy        : UInt32 = 0b0000 // Enemies only collide with other Enemies and Towers
    static let EnemyBullet       : UInt32 = 0b10000 // EnemyBullet only collides with TowerShield
    static let TowerBullet       : UInt32 = 0b00000 // TowerBullet does not collide with anything
}

struct ContactMask { // Which categories should this object trigger notifications about, i.e. in didBeginContact(). Match with categories above.
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Tower        : UInt32 = 0
    static let Enemy        : UInt32 = 0
    static let EnemyBullet  : UInt32 = 0b0001 // EnemyBullet should only trigger contacts with Towers, so they can deal damage then be destroyed
    static let TowerBullet  : UInt32 = 0b0010 // TowerBullet should only trigger contacts with Enemies, so they can deal damage then be destroyed
}

// Sets the Z position of an x,y,z cartesian plane
struct ZPosition {
    static let background  : CGFloat = -10
    static let wall         : CGFloat = 0
    static let tower        : CGFloat = 5
    static let enemy        : CGFloat = 6
    static let bullet       : CGFloat = 7
    static let camera       : CGFloat = 20
}

extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "gridBG")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
    
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}

// Returns closest enemy to given point
func getClosestEnemy(point : CGPoint, range : CGFloat) -> EnemyBase? {
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    var closestEnemy : EnemyBase?
    var closestDistance : CGFloat = 999999
    var tempDistance : CGFloat
    
    for e in appDelegate!.gameScene!.enemies {
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

// Returns a list of towers in range to given points range
func getTowersInRange(point : CGPoint, range : CGFloat) -> [TowerBase] {
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    var inRange : [TowerBase] = [TowerBase]()
    for t in appDelegate!.gameScene!.towers {
        if (getDistance(point,to:t.sprite.position) < range) {
            inRange.append(t);
        }
    }
    return inRange
}

// Returns a list of enemies in range to given points range
func getEnemiesInRange(point : CGPoint, range : CGFloat) -> [EnemyBase] {
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    var inRange : [EnemyBase] = [EnemyBase]()
    for e in appDelegate!.gameScene!.enemies {
        if (getDistance(point,to:e.sprite.position) < range) {
            inRange.append(e);
        }
    }
    return inRange
}

// Returns closest tower to given point
func getClosestTower(point : CGPoint) -> TowerBase? {
    let appDelegate =
    UIApplication.sharedApplication().delegate as? AppDelegate
    var closestTower : TowerBase?
    var closestDistance : CGFloat = 999999
    var tempDistance : CGFloat
    
    for t in appDelegate!.gameScene!.towers {
        tempDistance = getDistance(point,to: t.sprite.position)
        if (tempDistance < closestDistance) {
            closestDistance = tempDistance
            closestTower = t;
        }
    }
    
    return closestTower;
}

// adds gold when an enemy is detsroyed
func addGold(amount : Int) -> Bool{
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

// Resturns distance from two points
func getDistance(from : CGPoint, to : CGPoint) -> CGFloat {
    
    return CGFloat(sqrt(pow(from.x-to.x,2) + pow(from.y-to.y,2)))
}


func Clamp(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
    if (value < min) {
        return min
    }
    else if (value > max) {
        return max
    }
    else {
        return value
    }
}
func getItems() -> [Item]{
    if gameScene.scene != nil{
        return gameScene.items
    }
    else{
        return SideScrolScene.items
    }
}
//delay function that can be called as a clouser 
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
//Functions to handle random CGFloats
func random() -> CGFloat{
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min min: CGFloat, max: CGFloat) -> CGFloat{
    return random() * (max - min) + min
}
func randomVect(min min: CGFloat, max: CGFloat) -> CGVector{
    return CGVector(dx: random() * (max - min) + min, dy: 0)
}
func getVector(from : CGPoint, to : CGPoint, speed : CGFloat) -> CGVector {
    let dis : CGFloat = getDistance(from,to: to)
    return CGVectorMake((to.x - from.x)/dis * speed, (to.y - from.y)/dis * speed)
}
