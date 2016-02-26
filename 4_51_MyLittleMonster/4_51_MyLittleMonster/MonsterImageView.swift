//
//  MonsterImageView.swift
//  4_51_MyLittleMonster
//
//  Created by Edward P. Kelly on 2/25/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import UIKit

class MonsterImageView:UIImageView {
    
    private let NUMBER_OF_IDLE_IMAGES = 4
    private let NUMBER_OF_DEAD_IMAGES = 5
    private let IDLE_IMAGE_STRING = "idle"
    private let DEAD_IMAGE_STRING = "dead"
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    private func loadAnimationImages(imageType:String, imageCount:Int)
    {
        // set initial image
        image = UIImage(named: "\(imageType)\(imageCount).png")
        
        var imageArray = [UIImage]()
        for x in 1...imageCount {
            let image = UIImage(named: "\(imageType)\(x).png")
            imageArray.append(image!)
        }
        animationImages = imageArray
        animationDuration = 0.8
        animationRepeatCount = (imageType == DEAD_IMAGE_STRING) ? 1 : 0
        startAnimating()
    }
    
    func playIdleAnimations()
    {
        loadAnimationImages(IDLE_IMAGE_STRING, imageCount: NUMBER_OF_IDLE_IMAGES)
    }
    
    func playDeathAnimations()
    {
        loadAnimationImages(DEAD_IMAGE_STRING, imageCount: NUMBER_OF_DEAD_IMAGES)
    }
}