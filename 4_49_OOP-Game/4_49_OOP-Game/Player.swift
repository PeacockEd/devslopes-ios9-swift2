//
//  Player.swift
//  4_29_OOP-Game
//
//  Created by Edward P. Kelly on 2/22/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class Player:GameCharacter {
    
    private var _name = "Player"
    
    var name:String {
        get {
            return _name
        }
    }
    
    convenience init(name:String, startHealthPower:Int, attackPower:Int)
    {
        self.init(startHealthPower: startHealthPower, attackPower:attackPower)
        _name = name
    }
}
