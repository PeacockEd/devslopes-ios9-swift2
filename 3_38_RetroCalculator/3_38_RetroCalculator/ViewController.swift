//
//  ViewController.swift
//  3_38_RetroCalculator
//
//  Created by Edward P. Kelly on 2/14/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    @IBOutlet weak var displayLabel:UILabel!
    
    private var btnSound: AVAudioPlayer!
    private var runningNumber = ""
    private var leftValStr = ""
    private var rightValStr = ""
    private var result = ""
    private var currentOperation: Operation = .Empty
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberTapped(sender: UIButton!) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        displayLabel.text = runningNumber
    }
    
    @IBAction func divideTapped(sender: UIButton!) {
        performOperation(.Divide)
    }
    @IBAction func multiplyTapped(sender: UIButton!) {
        performOperation(.Multiply)
    }
    @IBAction func subtractTapped(sender: UIButton!) {
        performOperation(.Subtract)
    }
    @IBAction func addTapped(sender: UIButton!) {
        performOperation(.Add)
    }
    @IBAction func equalsTapped(sender: UIButton!) {
        performOperation(currentOperation)
    }
    
    private func performOperation(op:Operation) {
        playSound()
        
        if currentOperation != .Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                let operand1 = Double(leftValStr)!
                let operand2 = Double(rightValStr)!
                
                switch currentOperation {
                case .Multiply:
                    result = "\(operand1 * operand2)"
                case .Divide:
                    result = "\(operand1 / operand2)"
                case .Subtract:
                    result = "\(operand1 - operand2)"
                case .Add:
                    result = "\(operand1 + operand2)"
                default:
                    break
                }
                leftValStr = result
                displayLabel.text = result
            }
            
            currentOperation = op
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    private func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

