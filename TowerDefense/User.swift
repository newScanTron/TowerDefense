//
//  User.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/6/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation

class User
{
    //user Name and password to allow the game state to know
    //which states belong to which user.
    var userName: String
    var pswd: String
    var xp: Int = 0
    var gold: Int
    var o2 = 0
    var metal = 0
    var fuel = 0
    init()
    {
        self.userName = ""
        self.pswd = ""
        self.xp = 0
        self.gold = 2000
        self.o2 = 1000
        self.metal = 500
        self.fuel = 500
    }
    init(userName: String, pswd: String, xp: Int, gold: Int)
    {
        self.userName = userName
        self.pswd = pswd
        self.xp = xp
        self.gold = gold
        self.o2 = 1000
        self.metal = 500
        self.fuel = 500
    }
    init(userName: String, pswd: String, xp: Int, gold: Int, o2: Int, metal: Int, fuel: Int)
    {
        self.userName = userName
        self.pswd = pswd
        self.xp = xp
        self.gold = gold
        self.o2 = o2
        self.metal = metal
        self.fuel = fuel
    }
    //getters and setters
    func getUser() -> (userName: String, passwd: String)
    {
        return (self.userName, self.pswd)
    }
    func setUser(userName: String, psswd: String)
    {
        self.userName = userName
        self.pswd = psswd
    }
}