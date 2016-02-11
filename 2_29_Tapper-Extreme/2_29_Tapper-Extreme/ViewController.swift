//
//  ViewController.swift
//  2_29_Tapper-Extreme
//
//  Created by Edward P. Kelly on 2/11/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImage:UIImageView!
    @IBOutlet weak var tapCountTxt:UITextField!
    @IBOutlet weak var playButton:UIButton!
    
    @IBOutlet weak var tapButton:UIButton!
    @IBOutlet weak var tapsLabel:UILabel!
    
    @IBAction func onPlayTapped(sender: UIButton!) {
        logoImage.hidden = true
        playButton.hidden = true
        tapCountTxt.hidden = true
        tapButton.hidden = false
        tapsLabel.hidden = false
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

