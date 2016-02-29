//
//  BaseCharacter.swift
//  4_51_MyLittleMonster
//
//  Created by Edward P. Kelly on 2/27/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import AVKit

class BaseCharacter:UIImageView {
    
    private var _idleImageCount = 0
    private var _dyingImageCount = 0
    private var _idleImgString = ""
    private var _dyingImgString = ""
    private var _animationDuration = 0.0
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    var idleImageCount:Int {
        get {
            return _idleImageCount
        }
        set {
            _idleImageCount = newValue
        }
    }
    
    var dyingImageCount:Int {
        get {
            return _dyingImageCount
        }
        set {
            _dyingImageCount = newValue
        }
    }
    
    var idleImgString:String {
        get {
            return _idleImgString
        }
        set {
            _idleImgString = newValue
        }
    }
    
    var dyingImgString:String {
        get {
            return _dyingImgString
        }
        set {
            _dyingImgString = newValue
        }
    }
    
    var animDuration:Double {
        get {
            return _animationDuration
        }
        set {
            _animationDuration = newValue
        }
    }
    
    private func loadAnimationImages(imageType:String, imageCount:Int)
    {
        // set initial image
        image = UIImage(named: "\(imageType)\(imageCount - 1).png")
        
        var imageArray = [UIImage]()
        for x in 0..<imageCount {
            let image = UIImage(named: "\(imageType)\(x).png")
            imageArray.append(image!)
        }
        animationImages = imageArray
        animationDuration = _animationDuration
        animationRepeatCount = (imageType == _dyingImgString) ? 1 : 0
        startAnimating()
    }
    
    func playIdleAnimations()
    {
        loadAnimationImages(_idleImgString, imageCount: _idleImageCount)
    }
    
    func playDeathAnimations()
    {
        loadAnimationImages(_dyingImgString, imageCount: _dyingImageCount)
    }
}
