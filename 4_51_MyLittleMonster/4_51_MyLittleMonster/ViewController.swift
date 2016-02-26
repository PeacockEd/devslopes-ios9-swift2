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
    
    @IBOutlet weak var monsterImg:MonsterImageView!
    @IBOutlet weak var foodImg:DraggableImageView!
    @IBOutlet weak var heartImg:DraggableImageView!
    
    @IBOutlet weak var penaltyImg1:UIImageView!
    @IBOutlet weak var penaltyImg2:UIImageView!
    @IBOutlet weak var penaltyImg3:UIImageView!
    
    private var penaltyImageArray = [UIImageView]()
    private var totalPenalties = 0
    private var timer:NSTimer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monsterImg.playIdleAnimations()
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        penaltyImageArray = [penaltyImg1, penaltyImg2, penaltyImg3]
        
        setupUI()
        startTimer()
    }
    
    private func setupUI()
    {
        for img in penaltyImageArray {
            img.alpha = DIM_ALPHA
        }
    }
    
    private func startTimer()
    {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState()
    {
        totalPenalties++
        for x in 1...MAX_AMOUNT_OF_PENALTIES {
            penaltyImageArray[x - 1].alpha = (x <= totalPenalties) ? OPAQUE : DIM_ALPHA
        }
        if totalPenalties >= MAX_AMOUNT_OF_PENALTIES {
            gameOver()
        }
    }
    
    func gameOver()
    {
        timer.invalidate()
        monsterImg.playDeathAnimations()
    }
    
    func itemDroppedOnCharacter(notification: AnyObject)
    {
//        print("item dropped!!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

