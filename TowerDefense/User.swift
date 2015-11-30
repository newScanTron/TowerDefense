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
    init()
    {
        self.userName = ""
        self.pswd = ""
    }
    init(userName: String, pswd: String)
    {
        self.userName = userName
        self.pswd = pswd
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