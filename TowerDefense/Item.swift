//
//  Item.swift
//  TowerDefense
//
//  Created by Aaron Cameron on 12/2/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation
import SpriteKit

class Item {
    
    var destroyThis : Bool  = false
    
    init() {}
    
    func update ()  -> Void {
        //OVERRIDE THIS
    }
    
    func destroy() {
        //OVERRIDE THIS
    }
    
}