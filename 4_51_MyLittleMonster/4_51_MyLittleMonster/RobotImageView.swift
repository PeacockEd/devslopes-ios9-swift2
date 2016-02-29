//
//  RobotImageView.swift
//  4_51_MyLittleMonster
//
//  Created by Edward P. Kelly on 2/27/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class RobotImageView:BaseCharacter {
    
    override func awakeFromNib() {
        idleImageCount = 32
        dyingImageCount = 9
        idleImgString = "robot_idle_"
        dyingImgString = "robot_dying_"
        animDuration = 1.5
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}