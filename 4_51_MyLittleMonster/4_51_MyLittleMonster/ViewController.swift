//
//  ViewController.swift
//  4_51_MyLittleMonster
//
//  Created by Edward P. Kelly on 2/25/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let DIM_ALPHA:CGFloat = 0.2
    let OPAQUE:CGFloat = 1.0
    let MAX_AMOUNT_OF_PENALTIES = 3
    
    @IBOutlet weak var introBg:UIImageView!
    @IBOutlet weak var chooseLabel:UILabel!
    @IBOutlet weak var petChooserStackView:UIStackView!
    @IBOutlet weak var itemsStackView:UIStackView!
    
    @IBOutlet weak var monsterImg:MonsterImageView!
    @IBOutlet weak var foodImg:DraggableImageView!
    @IBOutlet weak var heartImg:DraggableImageView!
    @IBOutlet weak var maceImg:DraggableImageView!
    
    @IBOutlet weak var robotImg:RobotImageView!
    
    @IBOutlet weak var penaltyImg1:UIImageView!
    @IBOutlet weak var penaltyImg2:UIImageView!
    @IBOutlet weak var penaltyImg3:UIImageView!
    
    @IBOutlet weak var replayBtn:UIButton!
    
    private var penaltyImageArray = [UIImageView]()
    private var totalPenalties = 0
    private var timer:NSTimer!

    private var currentItem:UInt32 = 0
    
    private var gameController:GameController!
    private var sounds:SoundController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameController = GameController()
        gameController.currentPet = GameController.Pets.Golom
        
        sounds = SoundController()
        
        monsterImg.hidden = true
        robotImg.hidden = true
        
        introBg.hidden = false
        chooseLabel.hidden = false
        petChooserStackView.hidden = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        penaltyImageArray = [penaltyImg1, penaltyImg2, penaltyImg3]
    }
    
    private func startGame()
    {
        startTimer()
        
        sounds.playSound(sound: SoundController.Sounds.Background, loop: true)
        
        if let pet = getCurrentPetImage() {
            pet.hidden = false
            pet.playIdleAnimations()
            foodImg.dropTarget = pet
            heartImg.dropTarget = pet
            maceImg.dropTarget = pet
        }
        
        for img in penaltyImageArray {
            img.alpha = DIM_ALPHA
        }
        
        petChooserStackView.hidden = true
        introBg.hidden = true
        chooseLabel.hidden = true
        itemsStackView.hidden = false
        replayBtn.hidden = true
        petChooserStackView.removeFromSuperview()
        introBg.removeFromSuperview()
    }
    
    private func startTimer()
    {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    @IBAction func onReplayBtnTapped(sender:UIButton)
    {
        startGame()
    }
    
    @IBAction func onPetChosen(sender:UIButton)
    {
        if sender.tag == 0 {
            gameController.currentPet = GameController.Pets.Robot
        } else {
            gameController.currentPet = GameController.Pets.Golom
        }
        
        startGame()
    }
    
    func getCurrentPetImage() -> BaseCharacter?
    {
        if let currentPet = gameController.currentPet {
            switch currentPet {
            case GameController.Pets.Robot:
                return robotImg
            case GameController.Pets.Golom:
                return monsterImg
            }
        }
        return nil
    }
    
    func changeGameState()
    {
        if !gameController.isPetHappy {
            sounds.playSound(sound: SoundController.Sounds.Skull)
            totalPenalties++
            for x in 1...MAX_AMOUNT_OF_PENALTIES {
                penaltyImageArray[x - 1].alpha = (x <= totalPenalties) ? OPAQUE : DIM_ALPHA
            }
            if totalPenalties >= MAX_AMOUNT_OF_PENALTIES {
                gameOver()
                return
            }
        }
        let rand = arc4random_uniform(3) // 0, 1, or 2
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            maceImg.alpha = DIM_ALPHA
            maceImg.userInteractionEnabled = false
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else if rand == 1 {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            maceImg.alpha = DIM_ALPHA
            maceImg.userInteractionEnabled = false
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            maceImg.alpha = OPAQUE
            maceImg.userInteractionEnabled = true
        }
        currentItem = rand
        gameController.isPetHappy = false
    }
    
    func gameOver()
    {
        timer.invalidate()
        monsterImg.playDeathAnimations()
        robotImg.playDeathAnimations()
        
        sounds.playSound(sound: SoundController.Sounds.Death)
        
        replayBtn.hidden = false
    }
    
    func itemDroppedOnCharacter(notification: AnyObject)
    {
        gameController.isPetHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        maceImg.alpha = DIM_ALPHA
        maceImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sounds.playSound(sound: SoundController.Sounds.Heart)
        } else if currentItem == 1 {
            sounds.playSound(sound: SoundController.Sounds.Bite)
        } else {
            sounds.playSound(sound: SoundController.Sounds.Discipline)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

