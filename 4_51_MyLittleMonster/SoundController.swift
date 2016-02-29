//
//  SoundController.swift
//  4_29_OOP-Game
//
//  Created by Edward P. Kelly on 2/23/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import AVFoundation

class SoundController {
    
    enum Sounds {
        case Background, Bite, Death, Discipline, Heart, Skull
    }
    
    private var backgroundPlayer: AVAudioPlayer!
    private var bitePlayer: AVAudioPlayer!
    private var deathPlayer: AVAudioPlayer!
    private var heartPlayer: AVAudioPlayer!
    private var skullPlayer: AVAudioPlayer!
    private var disciplinePlayer: AVAudioPlayer!
    
    private var playerDictionary = [Sounds : AVAudioPlayer?]()
    
    
    init()
    {
        backgroundPlayer = preparePlayer(fileName: "cave-music", fileExt: "mp3")
        bitePlayer = preparePlayer(fileName: "bite", fileExt: "wav")
        deathPlayer = preparePlayer(fileName: "death", fileExt: "wav")
        heartPlayer = preparePlayer(fileName: "heart", fileExt: "wav")
        skullPlayer = preparePlayer(fileName: "skull", fileExt: "wav")
        disciplinePlayer = preparePlayer(fileName: "discipline", fileExt: "mp3")
        
        playerDictionary = [.Background:backgroundPlayer, .Bite:bitePlayer, .Death:deathPlayer, .Discipline:disciplinePlayer, .Heart:heartPlayer, .Skull:skullPlayer]
    }
    
    private func preparePlayer(fileName name:String, fileExt:String) -> AVAudioPlayer?
    {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: fileExt)
        let url = NSURL(fileURLWithPath: path!)
        
        return preparePlayer(url)
    }
    
    private func preparePlayer(url:NSURL) -> AVAudioPlayer?
    {
        do {
            let player = try AVAudioPlayer(contentsOfURL: url)
            player.prepareToPlay()
            return player
        } catch let error as NSError {
            print(error.debugDescription)
            return nil
        }
    }
    
    private func play(player:AVAudioPlayer, loop:Bool)
    {
        if player.playing {
            player.stop()
        }
        
        player.numberOfLoops = ((loop) ? -1 : 0)
        player.play()
    }
    
    private func stop(player:AVAudioPlayer)
    {
        player.stop()
    }
    
    func playSound(sound sound:Sounds, loop:Bool)
    {
        if let player = playerDictionary[sound], concretePlayer = player {
            if concretePlayer.playing {
                let newPlayer = preparePlayer(concretePlayer.url!)
                playerDictionary[sound] = nil
                concretePlayer.stop()
                newPlayer?.prepareToPlay()
                newPlayer?.play()
                playerDictionary[sound] = newPlayer
            } else {
                play(concretePlayer, loop: loop)
            }
        }
    }
    
    func playSound(sound sound:Sounds)
    {
        playSound(sound: sound, loop: false)
    }
    
    func stopSound(sound sound:Sounds)
    {
        if let player = playerDictionary[sound], concretePlayer = player { stop(concretePlayer) }
    }
    
    func stopAllSounds()
    {
        for (soundType, _) in playerDictionary {
            stopSound(sound: soundType)
        }
    }
}
