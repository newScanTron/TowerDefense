//
//  TowerDefenseTests.swift
//  TowerDefenseTests
//
//  Created by Chris Murphy on 10/27/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import XCTest
@testable import TowerDefense

class TowerDefenseTests: XCTestCase {
    
    var scene: GameScene = GameScene()
    override func setUp() {
        
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       scene = GameScene();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        scene.removeFromParent()
    }
    //this is a tottally contrived text but is an example of a passing test
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let enemey = EnemyFactory();
        XCTAssertEqual(enemey.CreateEnemy().range , enemey.CreateEnemy().range)
        
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
