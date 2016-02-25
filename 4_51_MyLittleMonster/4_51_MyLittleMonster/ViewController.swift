//
//  ViewController.swift
//  4_51_MyLittleMonster
//
//  Created by Edward P. Kelly on 2/25/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let NUMBER_OF_IMAGES = 4
    
    @IBOutlet weak var monsterImg:UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageArray = [UIImage]()
        for x in 1...NUMBER_OF_IMAGES {
            let image = UIImage(named: "idle\(x).png")
            imageArray.append(image!)
        }
        monsterImg.animationImages = imageArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

