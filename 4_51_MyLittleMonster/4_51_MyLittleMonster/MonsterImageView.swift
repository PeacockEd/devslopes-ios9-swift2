//
//  MonsterImageView.swift
//  4_51_MyLittleMonster
//
//  Created by Edward P. Kelly on 2/25/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class MonsterImageView:BaseCharacter {
    
    override func awakeFromNib() {
        idleImageCount = 4
        dyingImageCount = 5
        idleImgString = "idle_"
        dyingImgString = "dead_"
        animDuration = 0.8
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}