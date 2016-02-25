//
//  ViewController.swift
//  4_29_OOP-Game
//
//  Created by Edward P. Kelly on 2/18/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel:UILabel!
    @IBOutlet weak var attackBtn1:UIButton!
    @IBOutlet weak var attackBtn2:UIButton!
    @IBOutlet weak var gameOverLabel:UILabel!
    @IBOutlet weak var replayButton:UIButton!
    
    @IBOutlet weak var playerImage1:UIImageView!
    @IBOutlet weak var playerImage2:UIImageView!
    
    private var game:GameController!
    private var _gameStatus:String!
    private var timer:NSTimer?
    

    var gameStatus:String {
        get {
            if _gameStatus == nil {
                _gameStatus = ""
            }
            return _gameStatus
        }
        set {
            _gameStatus = newValue
            statusLabel.text = _gameStatus
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    @IBAction func attackTapped(sender:AnyObject) {
        if game.gameOver { return }
        
        if let button = sender as? UIButton {
            let attackerId = button.tag - 1
            let victimId = (attackerId == 0) ? 1 : 0
            
            game.attemptAttack(attackerId, victim: victimId)
            if !game.gameOver {
                disableOpponentAttackButton(victimId)
            }
            updateDisplay()
        }
    }
    
    @IBAction func replayTapped(sender:UIButton) {
        startGame()
    }
    
    private func updateDisplay() {
        gameStatus = game.status
        
        if game.gameOver {
            timer?.invalidate()
            attackBtn1.hidden = false
            attackBtn2.hidden = false
            attackBtn1.enabled = false
            attackBtn2.enabled = false
            gameOverLabel.hidden = false
            replayButton.hidden = false
        }
    }
    
    private func disableOpponentAttackButton(buttonId:Int) {
        toggleButtonVisibility(buttonId, visible: false)
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enableAttackButton:", userInfo: buttonId, repeats: false)
    }
    
    func enableAttackButton(timer:NSTimer) {
        if let buttonId = timer.userInfo as? Int {
            toggleButtonVisibility(buttonId, visible: true)
        }
    }
    
    private func toggleButtonVisibility(buttonId: Int, visible:Bool) {
        switch (buttonId) {
        case 0:
            attackBtn1.hidden = !visible;
        case 1:
            attackBtn2.hidden = !visible;
        default:
            break;
        }
    }
    
    private func startGame() {
        replayButton.hidden = true
        gameOverLabel.hidden = true
        
        attackBtn1.enabled = true
        attackBtn2.enabled = true
        
        let player1 = Player(name: "Orc", startHealthPower: GameController.generateRandomPower(upper: 100, lower: 80), attackPower: GameController.generateRandomPower(upper: 5, lower: 1))
        let player2 = Player(name: "Soldier", startHealthPower: GameController.generateRandomPower(upper: 100, lower: 80), attackPower: GameController.generateRandomPower(upper:10, lower: 1))
        game = GameController(players: [player1, player2])
        
        updateDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

