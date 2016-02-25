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
        case Intro, Background, Attack, Die
    }
    
    private var introPlayer: AVAudioPlayer!
    private var backgroundPlayer: AVAudioPlayer!
    private var attackPlayer: AVAudioPlayer!
    private var agonyPlayer: AVAudioPlayer!
    
    private var playerDictionary = [Sounds : AVAudioPlayer?]()
    
    
    init()
    {
        introPlayer = preparePlayer(fileName: "intro", fileExt: "wav")
        backgroundPlayer = preparePlayer(fileName: "background", fileExt: "wav")
        attackPlayer = preparePlayer(fileName: "attack", fileExt: "wav")
        agonyPlayer = preparePlayer(fileName: "dead", fileExt: "mp3")
        
        playerDictionary = [.Intro:introPlayer, .Background:backgroundPlayer, .Attack:attackPlayer, .Die:agonyPlayer]
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
