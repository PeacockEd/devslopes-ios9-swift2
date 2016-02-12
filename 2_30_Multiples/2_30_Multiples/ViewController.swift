//
//  ViewController.swift
//  2_30_Multiples
//
//  Created by Edward P. Kelly on 2/11/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var multipleValue = 0
    var currentSum = 0
    
    @IBOutlet weak var multiplesText:UITextField!
    @IBOutlet weak var logoImage:UIImageView!
    @IBOutlet weak var playButton:UIButton!
    
    @IBOutlet weak var sumLabel:UILabel!
    @IBOutlet weak var addButton:UIButton!
    
    @IBAction func onTapPlay(sender:UIButton!) {
        if multiplesText.text != nil &&
            multiplesText.text != "" &&
            (Int(multiplesText.text!) > 0)
        {
            logoImage.hidden = true
            playButton.hidden = true
            multiplesText.hidden = true
            sumLabel.hidden = false
            addButton.hidden = false
            multipleValue = Int(multiplesText.text!)!
        }
    }
    
    @IBAction func onTapAdd(sender:UIButton!) {
        sumLabel.text = "\(currentSum) + \(multipleValue) = \(calculateSum())"
        currentSum = calculateSum()
    }
    
    private func calculateSum() -> Int {
        return currentSum + multipleValue
    }
    
    private func restartGame() {
        multipleValue = 0
        currentSum = 0
        sumLabel.text = "Press Add to Add!"
        multiplesText.text = ""
        logoImage.hidden = false
        playButton.hidden = false
        multiplesText.hidden = false
        sumLabel.hidden = true
        addButton.hidden = true
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

