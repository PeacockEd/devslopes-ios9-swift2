//
//  GameController.swift
//  4_51_MyLittleMonster
//
//  Created by Edward P. Kelly on 2/27/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class GameController {
    
    enum Pets:String {
        case Robot = "robot"
        case Golom = "golom"
    }
    
    private var _currentPet:Pets?
    private var _isPetHappy = false
    
    init()
    {
    }
    
    
    var currentPet:Pets? {
        get {
            return _currentPet
        }
        set {
            _currentPet = newValue
        }
    }
    
    var isPetHappy:Bool {
        get {
            return _isPetHappy
        }
        set {
            _isPetHappy = newValue
        }
    }
}
