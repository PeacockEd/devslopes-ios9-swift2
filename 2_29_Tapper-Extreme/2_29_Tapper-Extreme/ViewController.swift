//
//  ViewController.swift
//  2_29_Tapper-Extreme
//
//  Created by Edward P. Kelly on 2/11/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Props
    var maxTaps = 0
    var currentTaps = 0
    
    // Outlets
    @IBOutlet weak var logoImage:UIImageView!
    @IBOutlet weak var tapCountTxt:UITextField!
    @IBOutlet weak var playButton:UIButton!
    
    @IBOutlet weak var tapButton:UIButton!
    @IBOutlet weak var tapsLabel:UILabel!
    
    @IBAction func onPlayTapped(sender: UIButton!) {
        
        if tapCountTxt.text != "" && tapCountTxt.text != nil {
            logoImage.hidden = true
            playButton.hidden = true
            tapCountTxt.hidden = true
            tapButton.hidden = false
            tapsLabel.hidden = false
            
            maxTaps = Int(tapCountTxt.text!)!
            currentTaps = 0
            
            updateTapsLabel()
        }
    }
    
    @IBAction func onCoinTapped(sender: UIButton!) {
        currentTaps++
        updateTapsLabel()
        
        if isGameOver() {
            restartGame()
        }
    }
    
    private func isGameOver() -> Bool {
        return currentTaps >= maxTaps
    }
    
    private func updateTapsLabel() {
        tapsLabel.text = "\(currentTaps) Taps"
    }
    
    private func restartGame() {
        maxTaps = 0
        tapCountTxt.text = ""
        
        logoImage.hidden = false
        playButton.hidden = false
        tapCountTxt.hidden = false
        tapButton.hidden = true
        tapsLabel.hidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

