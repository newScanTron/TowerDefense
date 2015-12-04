//
//  EndGameScene.swift
//  TowerDefense
//
//  Created by My Macbook Pro on 12/3/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class EndGameScene: SKScene {
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    func viewDidLoad() {
        
        self.view!.addBackground()
    }
    override func didMoveToView(view: SKView) {
        self.view!.addBackground()    
        /*let background = SKSpriteNode(imageNamed: "gridBG")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = ZPosition.background
        addChild(background)*/
    // You won
    let youWon = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        youWon.fontSize = 60
        youWon.text = "You Won"
        youWon.position = CGPoint(x: self.size.width/2, y: self.size.height - 100)
    addChild(youWon)
    // Gold
    let gold = SKSpriteNode(imageNamed: "gold")
    gold.position = CGPoint(x: 50, y: self.size.height-30)
    addChild(gold)
    
    let lblGold = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    lblGold.fontSize = 30
    lblGold.fontColor = SKColor.whiteColor()
    lblGold.position = CGPoint(x: 100, y: self.size.height-40)
    lblGold.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
    lblGold.text = String(format: "X %d", appDelegate.gameState.gold)
    addChild(lblGold)
    
    // Score
    let lblxp = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    lblxp.fontSize = 60
    lblxp.fontColor = SKColor.whiteColor()
    lblxp.position = CGPoint(x: self.size.width / 2, y: 300)
    lblxp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    lblxp.text = String(format: "%d", appDelegate.gameState.xp)
    addChild(lblxp)
    
    // High Score
    let lblHighGold = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    lblHighGold.fontSize = 30
    lblHighGold.fontColor = SKColor.cyanColor()
    lblHighGold.position = CGPoint(x: self.size.width / 2, y: 150)
    lblHighGold.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    lblHighGold.text = String(format: "High Score: %d", appDelegate.gameState.highGold)
    addChild(lblHighGold)
    
    // Try again
    let lblTryAgain = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    lblTryAgain.fontSize = 30
    lblTryAgain.fontColor = SKColor.whiteColor()
    lblTryAgain.position = CGPoint(x: self.size.width / 2, y: 50)
    lblTryAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    lblTryAgain.text = "Next Wave"
    addChild(lblTryAgain)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
    // Transition back to the Game
    let reveal = SKTransition.fadeWithDuration(0.5)
    let gameScene = GameScene(size: self.size)
    self.view!.presentScene(gameScene, transition: reveal)
}

}
