//
//  GameController.swift
//  4_29_OOP-Game
//
//  Created by Edward P. Kelly on 2/23/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class GameController {
    
    let NUMBER_OF_PLAYERS = 2
    
    private var _players = [Player]()
    private var _status:String!
    private var _gameOver:Bool!
    private var soundController:SoundController!
    
    private var _greetings = ["Nice day for a battle!", "Raise your shield!", "Prepare to joust!", "Fight to the last gasp!"]
    
    
    class func generateRandomPower(upper upper:UInt32, lower:UInt32) -> Int
    {
        let randomNumber = Int(arc4random_uniform(upper - lower) + lower)
        return randomNumber
    }
    
    var status:String {
        get {
            if _status == nil {
                _status = ""
            }
            return _status
        }
    }
    
    var gameOver:Bool {
        get {
            return _gameOver
        }
    }
    
    init?(players: [Player]) {
        if players.count != NUMBER_OF_PLAYERS {
            return nil
        }
        _players = players
        _gameOver = false
        _status = _greetings[Int(arc4random_uniform(UInt32(_greetings.count)))]
        
        soundController = SoundController()
        soundController.playSound(sound: SoundController.Sounds.Background, loop: true)
    }
    
    private func endGame()
    {
        _gameOver = true
        soundController.stopAllSounds()
        soundController.playSound(sound: SoundController.Sounds.Die)
        soundController.playSound(sound: SoundController.Sounds.Intro, loop: true)
    }
    
    func attemptAttack(attacker:Int, victim:Int)
    {
        if gameOver { return }
        
        soundController.playSound(sound: SoundController.Sounds.Attack)
        
        let attackPlayer = _players[attacker]
        let victimPlayer = _players[victim]
        victimPlayer.attemptAttack(attackPlayer.attackPower)
        if !victimPlayer.isAlive {
            endGame()
            _status = "\(attackPlayer.name) defeats \(victimPlayer.name)"
        } else {
            _status = "\(attackPlayer.name) attacks \(victimPlayer.name). Health Remaining: \(victimPlayer.healthPower)"
        }
    }
}
