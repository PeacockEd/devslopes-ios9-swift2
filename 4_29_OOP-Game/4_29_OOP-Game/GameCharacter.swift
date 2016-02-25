//
//  GameCharacter.swift
//  4_29_OOP-Game
//
//  Created by Edward P. Kelly on 2/22/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class GameCharacter {
    
    private var _healthPower = 100
    private var _attackPower = 10

    
    var attackPower:Int {
        get {
            return _attackPower
        }
    }
    
    var healthPower:Int {
        get {
            return _healthPower
        }
    }
    
    var isAlive:Bool {
        get {
            return _healthPower > 0
        }
    }
    
    init(startHealthPower:Int, attackPower:Int) {
        _healthPower = startHealthPower
        _attackPower = attackPower
    }
    
    func attemptAttack(attackPower:Int) {
        _healthPower -= attackPower
    }
}
